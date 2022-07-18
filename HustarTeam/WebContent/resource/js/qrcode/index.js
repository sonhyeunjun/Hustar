// //mysql 
const mysql = require('mysql')
const connection = mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: '1234',
    port: '3306',
    database: 'bbs/attendancep'
})
connection.connect();

const router = mysql.Router();
const jwt = require('parseJwt');
const secretObj = require('parseJwt');


 // TODO: JWT 생성
   // public String createJwt(int id){
     //   Date now = new Date();
       // return Jwts.builder()
         //       .setHeaderParam("type","jwt")
           //     .claim("id", id)
             //   .setIssuedAt(now)
               // .setExpiration(new Date(System.currentTimeMillis()+1*(1000*60*60*24*365)))
                //.signWith(SignatureAlgorithm.HS256, SecretKey.JWT_SECRET_KEY)
                //.compact();
   // }


function parseJwt (token) {
        var base64Url = token.split('.')[1];
        var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));

        return JSON.parse(jsonPayload);
    };


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



// 난수 메소드

// 난수 배열 객체 생성 함수
var randomArray = new Array();

// 난수 객체 선언
class RandomObject {
    constructor(n, t) {
        this.rn = n;
        this.ct = t;
    }
}

// 난수 객체 배열 초기화
function initRandomArray(QRCode) {
    for (let i = 0; i < 65; i++) {
        let min = Math.ceil(1000000000);  //10억 10자리
        let max = Math.floor(10000000000);    //100억 11자리
        let randomNum = Math.floor(Math.random() * (max - min)) + min;   //10자리의 랜덤 값

        let time = new Date();
        let currentTime = time.getTime(); //밀리초 단위로 환산  


        randomArray.push(new RandomObject(randomNum, currentTime));
    }
}

// 여기에 출석인지 지각인지 결석인지를 결정한다.
// 그러면 출석 인정시간을 db에서 가져와야 한다.
// 현재 배열에서 같은 값이 있는지 검증 한다.
function checkRandomArray(qrNum, allowTime, startTimeHour, startTimeMinute, lt, at) {
    console.log("check Random Array start, the parameters is...")

    // 검증1 배열 앞부분의 5개의 RandomObject를 꺼낸다.
    firstRandomObject = randomArray[0];
    secondRandomObject = randomArray[1];
    thirdRandomObject = randomArray[2];
    fourthRandomObject = randomArray[3];
    fifthRandomObject = randomArray[4];

    // 5번째 값의 ct + 5초의 값이 allowTime보다 큰지 먼저 검사
    if (fifthRandomObject.ct + 5000 > allowTime) {
        // 통과하면 5개의 넘 값중에 같은 난수값이 있는지 확인

        if (firstRandomObject.rn == qrNum || secondRandomObject.rn == qrNum || thirdRandomObject.rn == qrNum || fourthRandomObject.rn == qrNum || fifthRandomObject.rn == qrNum) {
            // 출석인지 지각인지 결석인지 결정

            // 현재의 년, 월, 일을 구하자.
            let currentYear = new Date().getUTCFullYear();
            let currentMonth = new Date().getMonth();
            let currentDate = new Date().getDate();

            // 먼저 비교 가능하게 1970년 이후의 밀로초 값으로 만들자
            let testCurrentTime = new Date(currentYear, currentMonth, currentDate, startTimeHour, startTimeMinute, 0);

            let millie1970StartTime = testCurrentTime.getTime();//수업시간
            millie1970StartTime = millie1970StartTime;

            let mTime = minusTime(fifthRandomObject.ct, millie1970StartTime);
            // console.log(" mTime < lateTime = ",  mTime < lateTime, typeof(mTime) )
            if (mTime < lt) {
                // 출석
                console.log('출석')
                return 2;
            } else if (mTime < at) {
                // 지각
                console.log('지각')
                return 1;
            } else {
                // 결석
                console.log('결석')
                return 0;
            }
        }
    }
    return -1;
}

function minusTime(a, b) {
    a = (a / 60000) + 540;
    b = (b / 60000)
    return a - b;
}

// 배열의 앞부부을 지우고 뒷 부분을 새로 만드는
function doingChange(QRCode) {
    let min = Math.ceil(1000000000);  //10억 10자리
    let max = Math.floor(10000000000);    //100억 11자리
    let randomNum = Math.floor(Math.random() * (max - min)) + min;   //10자리의 랜덤 값


    let time = new Date();
    let currentTime = time.getTime(); //밀리초 단위로 환산

    // 새로운 값을 추가하고
    randomArray.unshift(new RandomObject(randomNum, currentTime));

    // 가장 오래된, 뒤에 있는 값을 제거한다.
    randomArray.pop();
}

// 특정 함수를 1초마다 반복한다.
function doingChangeOneSecond(QRCode) {
    setInterval(doingChange, 1000);
}



initRandomArray();  // 난수 배열 65개? 값 채움
doingChangeOneSecond(); // 배열의 값을 1초마다 바꾸기