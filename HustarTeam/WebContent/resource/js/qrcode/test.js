const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const secretObj = require('../../config/jwt');

// //mysql 
const mysql = require('mysql')
const connection = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: '1234',
    port: '3306',
    database: 'bbs'
})
connection.connect();

// 4-1 preOpen
router.post('/preOpen', (req, res) => {
    let token = req.headers['x-access-token'] || req.query.token;

    if (!token) {
        res.json({
            message: '토큰이 없습니다.',
            error: 'true'
        })
        return;
    }
    jwt.verify(token, secretObj.secret, (err, decoded) => {
        if (err) {
            res.json({
                message: '잘못된 토큰이 왔습니다.',
                error: true
            })
            return;
        }

        let class_id = req.body.class_id;

        connection.query(`
            select when_is_opened_getTime, week
            from classList
            where id = ?
        `, [class_id], (err, result) => {
            if (err) {
                console.error(err);
                throw err;
            }

            let getTime = result[0].when_is_opened_getTime;
            let week = result[0].week;

            let newToken = jwt.sign(
                { logId: decoded.logId },
                secretObj.secret,
                { expiresIn: '2h' }
            )

            res.json({
                getTime,
                week,
                error: false,
                token: newToken
            })
        })
    })
})

// 4-2. 교수 수업 개설. qr/open
router.post('/open', (req, res) => {
    let token = req.headers['x-access-token'] || req.query.token;

    if (!token) {
        res.json({
            message: '토큰이 없습니다.',
            error: 'true'
        })
        return;
    }
    jwt.verify(token, secretObj.secret, (err, decoded) => {
        if (err) {
            res.json({
                message: '잘못된 토큰이 왔습니다.',
                error: true
            })
            return;
        }


        let {
            classListId,
            classStartTimeHour,  // 1. 교수의 수업시간, 2. 교수가 임의로 정한시간, 3. 뭐 어쨋든 잘 알아서 프론트에선 넘어온 값
            week
        } = req.body;

        console.log("프론트가 보내줘야 하는 값 목록: ")
        console.log("professor_login_id: ", decoded.logId);
        console.log("classListId: ", classListId);
        console.log("classStartTimeHour: ", classStartTimeHour);
        console.log("week: ", week);
        console.log();

        let date = classStartTimeHour;
        let flag = false; // 만약 이미 수업이 열려있는 경우 판단하는 flag이다.
        let is_none = false;    // 없는 수업을 요청하였을  경우 판단하는 값
        let is_week_already_exist = false;
        console.log("decoded.logId: ", decoded.logId)

        connection.query(`
            select cl.id, isOpened
            from classList as cl
            left join professor as p on p.id = cl.professor_id
            where p.login_id = ?
        `, [decoded.logId], (err2, classList) => {
            if (err2) {
                console.error(err2);
                throw err2;
            }

            console.log("classList: ")
            console.log(classList)
            // 해당 교수의 모든 수업을 검사한다. 다른 수업이 열려있으면 닫기 위해서.
            for (let i = 0; i < classList.length; i++) {
                if (classList[i].isOpened && classList[i].id != classListId) {
                    console.log("한 교수에서 열고 싶은 수업 이외에 다른 수업이 열려있는 경우 자동을 닫인다.");
                    connection.query(`
                        update classList
                        set isOpened = ?
                        where id = ?
                    `, [false, classList[i].id], (err3, update_result) => {
                        if (err3) {
                            console.error(err3);
                            throw err3;
                        }
                    })
                } else if (classList[i].id == classListId) {
                    is_none = true;
                    console.log("현재 개설하려는 수업이 생성되어 있음을 확인하였습니다.")
                    connection.query(`
                        update classList
                        set isOpened = ?, when_is_opened = ?, week = ?, when_is_opened_getTime = ?
                        where id = ?
                    `, [true, date, week, new Date().getTime(), classListId], (err3, update_result) => {
                        if (err3) {
                            console.error(err3);
                            throw err3;
                        }
                        console.log("유저로 부터 입력받은 값으로 수업의 속성들을 update했습니다.");

                        // 같은 회차가 존재하는지 확인해 본다.
                        connection.query(`
                            select week 
                            from week
                            where class_id = ?
                        `, [classListId], (err4, result4) => {
                            if (err4) {
                                console.error(err4);
                                throw err4;
                            }

                            for (let i = 0; i < result4.length; i++) {
                                let i_week = result4[i].week;
                                if (i_week == week) {
                                    is_week_already_exist = true;
                                    console.log("error: 현재 해당 회차는 이미 존재합니다.")
                                    break;
                                }
                            }

                            if (!is_week_already_exist) {
                                console.log("수업의 회차를 저장하려 하고 있습니다.");
                                connection.query(`
                                    INSERT INTO week (week, class_day, class_time, class_id) 
                                    VALUES (?, ?, ?, ?);
                                `, [week, new Date(), date, classListId], (err5, result5) => {
                                    if (err5) {
                                        console.error(err5)
                                        throw err5;
                                    }
                                    console.log("=====================================================");
                                    console.log(`${classListId}번째 수업의 ${week}회차가 생성되었습니다.`);
                                    console.log("=====================================================");

                                    // 해당 수업에 등록한 학생 전부 attendance를 생성한다.
                                    console.log("해당 수업에 등록한 학생 전부의 attendance를 생성하겠습니다.")
                                    connection.query(`
                                        select student_id, cl.*
                                        from Student_has_class as sc
                                        left join classList as cl on cl.id = sc.class_id
                                        where sc.class_id = ?
                                    `, [classListId], (err4, result8) => {
                                        if (err4) {
                                            console.error(err4);
                                            throw err4;
                                        }

                                        if (result8.length == 0) {
                                            // 모든 결과가 끝남
                                            let newToken = jwt.sign(
                                                { logId: decoded.logId },
                                                secretObj.secret,
                                                { expiresIn: '2h' }
                                            )

                                            res.json({
                                                message: `현재 등록된 학생이 존재하지 않습니다.`,
                                                error: false,
                                                token: newToken,
                                            })
                                            return;
                                        }

                                        let class_day = new Date();
                                        let class_time = result8[0].when_is_opened;
                                        let class_week = result8[0].week;
                                        console.log("class_day: ", class_day);
                                        console.log("class_time: ", class_time);
                                        console.log("class_week: ", class_week);


                                        console.log(`${classListId} 수업을 등록한 모든 학생의 attendance를 추가하도록 하겠습니다.`)
                                        console.log(`추가하려는 학생 목록: `)
                                        for (let i1 = 0; i1 < result8.length; i1++) {
                                            console.log(`${result8[i1].student_id} 을 생성하겠습니다.`)
                                            let student_id_i1 = result8[i1].student_id;

                                            connection.query(`
                                                insert into attendance (record, reason, created_day, created_time, updated_day, updated_time, is_verified, week_id, student_id, class_id)
                                                values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                                            `, ["결석", "", class_day, class_time, class_day, class_time, 0, class_week, student_id_i1, classListId], (err5, result5) => {
                                                if (err5) {
                                                    console.error(err5);
                                                    throw err5;
                                                }

                                                console.log(`${result5.insertId}번째 학생의 출석을 생성하였습니다.`)
                                            })
                                        }
                                    })
                                })
                            }
                        })
                    })
                }
            }
            if (!is_none) {   // 없는 수업에 대한 요청을 할 경우
                res.json({
                    message: "없는 수업의 요청입니다.",
                    error: true
                })
                return;
            }

            if (!flag && !is_week_already_exist) {
                // 모든 결과가 끝남
                let newToken = jwt.sign(
                    { logId: decoded.logId },
                    secretObj.secret,
                    { expiresIn: '2h' }
                )

                res.json({
                    message: `isOpened 완료`,
                    error: false,
                    token: newToken,
                    date
                })
            }
        })
    })
})

// 6-1 python요청
router.post('/python', (req, res) => {
    let token = req.headers['x-access-token'] || req.query.token;

    if (!token) {
        res.json({
            message: '토큰이 없습니다.',
            error: 'true'
        })
        return;
    }
    jwt.verify(token, secretObj.secret, (err, decoded) => {
        if (err) {
            res.json({
                message: '잘못된 토큰이 왔습니다.',
                error: true
            })
            return;
        }
        console.log(decoded);

        let prof_id = decoded.logId;

        connection.query(`
            select isOpened, code, when_is_opened
            from classList as cl
            left join professor as p on p.id = cl.professor_id
            where p.login_id = ?
        `, [prof_id], (err, result) => {
            if (err) throw err;

            let flag = false;
            let index = -1;

            for (let i = 0; i < result.length; i++) {
                console.log("result[0].isOpened = " + result[0].isOpened)

                if (result[i].isOpened) {
                    console.log("현재 특정 수업이 열렸음을 확인하였습니다. 해당 수업의 코드는: ", result[i].code, " 입니다.");
                    flag = true;
                    index = i;
                    break;
                }
            }

            if (flag) {
                let attendanceTime = result[index].when_is_opened;  //현재 시간 -> 인국이 형이 보내는 시간 기주능러 할 것
                let perceptionTime = attendanceTime % 60;  // 지각 시간 
                attendanceTime = Math.floor(attendanceTime / 60);
                console.log("현재 열려있는 수업의 시작 시간: ", attendanceTime);
                console.log("현재 열려있는 수업의 분  시간 : ", perceptionTime);

                let qrJsonPack = {
                    error: false,
                    randomNum: randomArray[0].rn + '' + result[index].code,
                    attendanceTime: attendanceTime,
                    perceptionTime: perceptionTime
                }

                res.json(qrJsonPack);
            } else {
                res.json({
                    error: true,
                    message: "현재 어떤 수업도 열지 않았습니다."
                })
            }
        })
    })
})

// 6. 1초 마다 들어오는 qr 요청
router.post('/desk', (req, res) => {

    let classListID = req.body.classListId;
    console.log("프론트가 보내줘야 하는 값, classListId : ", classListID);

    // 먼저 해당 과목의 isOpened가 true인지 확인한다.
    connection.query(`
        select isOpened, code, when_is_opened
        from classList
        where id  = ?
    `, [classListID], function (err, result) {
        if (err) {
            console.error(err);
            throw err;
        }


        if (result[0].isOpened == 1) {

            let attendanceTime = result[0].when_is_opened;  // 교수가 설정한 수업 시작 시간.
            attendanceTime = Math.floor(attendanceTime / 60);

            let qrJsonPack = {
                error: false,
                randomNum: randomArray[0].rn + '' + result[0].code,
                attendanceTime: attendanceTime
            }

            res.json(qrJsonPack);

        } else if (result[0].isOpened == 0) {
            console.log("현재 해당 과목은 개설되지 않았습니다. 임시값 10000000000를 보냅니다.");

            let attendanceTime = new Date().getTime();

            let qrJsonPack = {
                error: true,
                randomNum: -1,
                attendanceTime: attendanceTime
            }

            res.json(qrJsonPack);
        } else {
            console.log("isOpened값을 잘못 확인하였다. 수정 요망");
            res.send('isOpened값을 잘못 확인하였다. 수정 요망')
        }
    })
})


// 4. 학생 qr코드 인증 req
router.post('/verify', (req, res) => {
    let token = req.headers['x-access-token'] || req.query.token;
    let {
        qrNum,
        allowTime  // allowTime 은 밀리초 단위, 방금 학생이 찍었을 때 시간                
    } = req.body;


    if (!token) {
        res.json({
            message: '토큰이 없습니다.',
            error: 'true'
        })
        return;
    }
    jwt.verify(token, secretObj.secret, (err, decoded) => {
        if (err) {
            res.json({
                message: '잘못된 토큰이 왔습니다.',
                error: true
            })
            return;
        }


        let login_id = decoded.logId; // student_login_id

        connection.query(`
            select s.id as id, class_id
            from student as s
            left join Student_has_class as sc on sc.student_id = s.id
            where s.login_id = ?
        `, [login_id], (err, student) => {
            if (err) throw err;

            let studentID = student[0].id;

            let current_hour = new Date().getHours();
            let current_minute = new Date().getMinutes();
            let current_student_time = ((current_hour * 60) + current_minute);

            // qrNum의 뒤에 3자리(수업 코드는 따로 떼어낸다.)
            qrNum = qrNum + "";
            let onlyRandomNum = qrNum.substring(0, 10);
            let classCode = Math.floor(qrNum.substring(10, qrNum.length));
            console.log("qrNum = " ,  qrNum);
            console.log("classCode = " + classCode);

            connection.query(`
                select * 
                from classList as cl 
                where cl.code = ?
            `, [classCode], (err4, result4) => {
                if (err4) throw err4;

                // 해당 학생이 이 수업을 듣고있는 지 확인
                let is_have_class = false;
                let is_have_class_index = 0;
                for (let ii = 0; ii < student.length; ii++) {
                    if (student[ii].class_id == result4[0].id) {
                        is_have_class = true;
                        is_have_class_index = ii;
                        break;
                    }
                }
                // 만약 없다면 추가해주고 마저 진행
                if (!is_have_class) {
                    console.log("새로운 등록이 필요한 학생입니다.")
                    connection.query(`
                        INSERT INTO Student_has_class (student_id, class_id) 
                        VALUES (?, ?);                    
                    `, [student[is_have_class_index].id, result4[0].id], (err7, result7) => {
                        if (err7) {
                            console.error(err7)
                            throw err7;
                        }
                        console.log(" ")
                        console.log(`${student[is_have_class_index].id}번 째 학생과 ${result4[0].id}의 수업을 이어주었습니다.`)
                        console.log(" ")

                        let class_day_1 = new Date();
                        let class_time_1 = result4[0].when_is_opened;
                        let class_week_1 = result4[0].week;
                        let student_id_1 = studentID;
                        let class_id_1 = result4[0].id;
                        console.log("새로 출결을 만드는데 필요한 값들 목록: ");
                        console.log("class_day_1: ", class_day_1);
                        console.log("class_time_1: ", class_time_1);
                        console.log("class_week_1: ", class_week_1);
                        console.log("student_id_1: ", student_id_1);
                        console.log("class_id_1: ", class_id_1);

                        // 해당 학생의 attendance를 새로 추가해줘야함
                        connection.query(`
                            insert into attendance (record, reason, created_day, created_time, updated_day, updated_time, is_verified, week_id, student_id, class_id)
                            values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                        `, ["결석", "", class_day_1, class_time_1, class_day_1, class_time_1, 0, class_week_1, student_id_1, class_id_1], (err7, result7) => {
                            if (err7) {
                                console.error(err7);
                                throw err7;
                            }

                            let classStartTimeHour = result4[0].when_is_opened;

                            console.log("classStartTimeHour = " + classStartTimeHour);
                            console.log("qr인증 test");

                            // 현재 db의 classList의 상태 역시 확인한다.
                            checkClassStatus(classCode, classStartTimeHour, onlyRandomNum, allowTime, current_student_time, studentID, res);
                        })


                    })
                } else {
                    console.log("이미 등록된 학생입니다!!!")
                    let classStartTimeHour = result4[0].when_is_opened;

                    console.log("classStartTimeHour = " + classStartTimeHour);
                    console.log("qr인증 test");

                    // 현재 db의 classList의 상태 역시 확인한다.
                    checkClassStatus(classCode, classStartTimeHour, onlyRandomNum, allowTime, current_student_time, studentID, res);
                }
            })
        })
    })
})  //실제로 테스트 해 봐야하는 ** 가장 중요


// 4-1 2차 qr코드 검증
router.post('/second_verify', (req, res) => {
    let token = req.headers['x-access-token'] || req.query.token;
    let {
        qrNum,
        allowTime  // allowTime 은 밀리초 단위, 방금 학생이 찍었을 때 시간                
    } = req.body;

    if (!token) {
        res.json({
            message: '토큰이 없습니다.',
            error: 'true'
        })
        return;
    }
    jwt.verify(token, secretObj.secret, (err, decoded) => {
        if (err) {
            res.json({
                message: '잘못된 토큰이 왔습니다.',
                error: true
            })
            return;
        }
        let login_id = decoded.logId; // student_login_id

        connection.query(`
            select s.id as id, class_id
            from student as s
            left join Student_has_class as sc on sc.student_id = s.id
            where s.login_id = ?
        `, [login_id], (err, student) => {
            if (err) throw err;

            let studentID = student[0].id;

            qrNum = qrNum + "";
            let onlyRandomNum = qrNum.substring(0, 10);
            let classCode = Math.floor(qrNum.substring(10, qrNum.length));
            console.log("classCode = " + classCode);

            let current_hour = new Date().getHours();
            let current_minute = new Date().getMinutes();
            let current_student_time = ((current_hour * 60) + current_minute);


            // 1. 출결의 2차 값을 채워야한다.? 일단 검사를 진행하고 맞으면 그때 날짜, 시간, 결과를 각각 채운다.
            // 2. 그런 결과를 log에도 반영 근데 이건 나중에 할 일
            // 3. 1차와 2차의 결과를 가져와서 비교한 뒤 높은 값을 다시 1차의 결과에 채운다. 그리고 해당 결과으이 날짜 시간 이유를 채운다.
            // 이때 이유는 바뀌었을 때만 바뀜



        })
    })
}) // 미완


module.exports = router;


// 현재 db의 classList의 상태 역시 확인한다.
function checkClassStatus(classCode, classStartTimeHour, onlyRandomNum, allowTime, current_student_time, studentID, res) {
    // 현재 db의 classList의 상태 역시 확인한다.
    connection.query(`
        select isOpened, id, week, lateTime, absentTime
        from classList
        where code = ?
    `, [classCode], function (err, result) {
        if (err) throw err;

        // 현재 학생이 qr검사를 재시도하는 것은 아닌지 확인한다.
        connection.query(`
            select is_verified
            from attendance as att
            where week_id = ? and student_id = ? and class_id = ?
        `, [result[0].week, studentID, result[0].id], (err0, result0) => {
            if (err0) {
                console.error(err0);
                throw err0;
            }

            console.log("특정 학생의 출결 정보: ")
            console.log("재시도인지?")
            if (result0[0].is_verified == 1) {
                console.log("현재 요청은 재시도 입니다. error를 내보냅니다.")

                res.json({
                    error: true,
                    message: "현재 학생은 qr검사를 재시도하고 있습니다. 해당 요청은 거부됩니다."
                })
                return;
            }
            else {
                console.log("현재 요청은 재시도가 아닙니다. 정상적으로 요청을 진행합니다.");
                console.log("result[0].week = " + result[0].week);

                let lateTime = makeLateTime(allowTime, classStartTimeHour);

                let classStartTimeMinute = (classStartTimeHour * 1) % 60; // 나머지를 구함으로써 분(minute)을 구한다.
                classStartTimeHour = Math.floor(classStartTimeHour / 60);

                console.log("classStartTimeHour: " + classStartTimeHour);
                console.log("classStartTimeMinute: " + classStartTimeMinute);

                // 변수에 classList의 상태를 저장한다.
                let classIsOpened = result[0].isOpened;
                console.log("classIsOpened = ", classIsOpened);

                // 받은 QR_난수, 허용_시간, 수업_시작_시, 수업_시작_분

                let isAllow = checkRandomArray(onlyRandomNum, allowTime, classStartTimeHour, classStartTimeMinute, result[0].lateTime, result[0].absentTime);
                console.log("isAllow = " + isAllow);

                // 학생의 시간 + 분
                
                // 실제 출결을 업데이트 하는 함수
                updateAttendanceFunc(isAllow, classIsOpened, current_student_time, result, studentID, lateTime, res)
            }
        })
    })
}

function makeLateTime(allowTime, classStartTimeHour) {
    if(!allowTime) return -1;
    let allowDate = new Date(allowTime);
    let allowHourMinute = allowDate.getHours() + allowDate.getMinutes();

    console.log("allowHourMinute: ", allowHourMinute);
    console.log("classStartTimeHour: ", classStartTimeHour);

    let lateTime = allowHourMinute - classStartTimeHour;
    return lateTime;
}

// 실제 출결을 업데이트 하는 함수
function updateAttendanceFunc(isAllow, classIsOpened, current_student_time, result, studentID, lateTime, res) {
    // class의 상태와 시간 값, 난수 값 모두 일치한다면 
    if (isAllow == 2 && classIsOpened) {      // week속성 값을 update해주어야 한다.
        // db에 해당 요청의 학생의 attendance를 출석 update한다.
        connection.query(`
            UPDATE attendance 
            SET record = ?, reason = ?, created_day = ?, created_time = ?, updated_day = ?, updated_time = ?, is_verified = 1
            WHERE week_id = ? and student_id = ? and class_id = ?
        `, ["출석", " ", new Date(), current_student_time, new Date(), current_student_time, result[0].week, studentID, result[0].id], function (err2, result2) {
            if (err2) {
                console.error(err2);
                throw err2;
            }
            // 출석 입력 완료
            console.log("result[0].id = " + result[0].id)
            console.log("출석 변경 완료. ")
            res.send("출석")
        })
    } else if (isAllow == 1 && classIsOpened) {
        // db에 해당 요청의ㅣ 학생의 attendance를 지각으로 update한다.
        connection.query(`
            UPDATE attendance 
            SET record = ?, reason = ?, created_day = ?, created_time = ?, updated_day = ?, updated_time = ?, is_verified = 1
            WHERE week_id = ? and student_id = ? and class_id = ?
        `, ["지각", `출석 시간으로 부터 ${lateTime}분 늦었습니다.`, new Date(), current_student_time, new Date(), current_student_time, result[0].week, studentID, result[0].id], function (err2, result2) {
            if (err2) {
                console.error(err2);
                throw err2;
            }
            // 지각 입력 완료
            console.log("지각 입력 완료. ")
            res.send("지각")
        })
    } else if (isAllow == 0 && classIsOpened) {
        // db에 해당 요청의 학생 attendance를 결석으로 update한다.
        connection.query(`
            UPDATE attendance 
            SET record = ?, reason = ?, created_day = ?, created_time = ?, updated_day = ?, updated_time = ?, is_verified = 1
            WHERE week_id = ? and student_id = ? and class_id = ?
        `, ["결석", `출석 시간으로 부터 ${lateTime}분 늦었습니다.`, new Date(), current_student_time, new Date(), current_student_time, result[0].week, studentID, result[0].id], function (err2, result2) {
            if (err2) {
                console.error(err2);
                throw err2;
            }
            // 결석 입력 완료
            console.log("결석 입력 완료. ")
            res.send("결석")
        })
    } else {
        console.log("isAllow = ", isAllow);
        console.log("classIsOpened = ", classIsOpened);
    }
}



