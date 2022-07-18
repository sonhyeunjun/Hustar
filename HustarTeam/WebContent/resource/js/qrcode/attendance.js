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

// 4-1. 교수 출결 조회, 교수가 자신의 과목에 대한 전 회차 또는 각 회차 출결리스트 반환
router.get('/', (req, res) => {
    let token = req.headers['x-access-token'] || req.query.token;
    let class_id = req.query.classListID;
    let week = req.query.att_week;

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


        // let professor_id = req.body.professor_ID;

        console.log("프론트에서 특정 수업의 출결을 알고 싶은 경우 주어야하는 파라미터 값들: ")
        console.log("class_id: ", class_id);
        console.log("att_week: ", week, "이 값은 없다면 모든 회차의 출결을 알고싶은 경우이다.");
        console.log("");


        if (week) {  // 특정 회차의 출결을 보고싶은 경우
            console.log("회차가 있다.")
            connection.query(`
                select att.id as attendance_id, att.record as studentState, att.reason, st.name, st.no as studentNo, att.created_day, att.created_time,att.updated_day, att.updated_time, is_fingerprint, is_gtx, is_qr, is_passive, is_verified, we.class_day, we.class_time
                from attendance as att
                left join student as st on st.id = att.student_id
                left join week as we on we.week = att.week_id
                where att.class_id = ? and att.week_id = ? and we.class_id = ?
            `, [class_id, week, class_id], (err, attendanceArr) => {
                if (err) {
                    console.error(err);
                    throw err;
                }

                let attend_count = 0;
                let late_count = 0;
                let absent_count = 0;

                if (attendanceArr.length == 0) {
                    console.log("Warning: 현재 등록된 학생이 없어 출결의 정보를 반환할 수 없습니다.")
                    let att_arr = [];
                    let class_day = null;
                    let class_time = null;
                    //jwt 생성 후 전송
                    let newToken = jwt.sign(
                        { logId: decoded.logId },
                        secretObj.secret,
                        { expiresIn: '5m' }
                    )
                    res.json({
                        att_arr,
                        attend_count,
                        late_count,
                        absent_count,
                        class_day,
                        class_time,
                        token: newToken,
                        error: false,
                        message: `Warning: 현재 등록된 학생이 없어 출결의 정보를 반환할 수 없습니다.`
                    })
                    return;
                }

                let att_arr = Object.values(attendanceArr);
                let class_day = attendanceArr[0].class_day;
                console.log("week_day = ", class_day );
                let class_time = attendanceArr[0].class_time;

                for (let i = 0; i < att_arr.length; i++) {
                    if (att_arr[i].studentState == '출석') {
                        attend_count++;
                    } else if (att_arr[i].studentState == '지각') {
                        late_count++;
                    } else if (att_arr[i].studentState == '결석') {
                        absent_count++;
                    }
                }

                //jwt 생성 후 전송
                let newToken = jwt.sign(
                    { logId: decoded.logId },
                    secretObj.secret,
                    { expiresIn: '5m' }
                )

                console.log("한 회차의 모든 출결 정보 배열: ", att_arr);
                console.log("한 회차의 모든 출석 정보: ", attend_count);
                console.log("한 회차의 모든 지각 정보: ", late_count);
                console.log("한 회차의 모든 결석 정보: ", absent_count);

                res.json({
                    att_arr,
                    attend_count,
                    late_count,
                    absent_count,
                    class_day,
                    class_time,
                    token: newToken,
                    error: false,
                    message: `${class_id} 번 수업 Open.`
                })
            })
        } else {     // 전 회차의 각각의 회차의 모든 출결 정보 return;
            connection.query(`
                select * 
                from week as we
                where we.class_id = ?
                group by we.week
                order by we.week
            `, [class_id], (err1, week_result) => {
                if (err1) {
                    console.error(err1);
                    throw err1;
                }

                let attendance_count = 0;
                let late_count = 0;
                let absent_count = 0;
                let week_object = {};

                let result_arr = [];
                if (week_result.length == 0) {
                    //jwt 생성 후 전송
                    let newToken = jwt.sign(
                        { logId: decoded.logId },
                        secretObj.secret,
                        { expiresIn: '5h' }
                    )

                    let result10 = {
                        result_arr,
                        error: false,
                        message: "잘 보내짐",
                        token: newToken
                    }
                    res.json(result10)
                } else {
                    for (let i = 0; i < week_result.length; i++) {
                        connection.query(`
                            select * 
                            from attendance as att
                            where att.week_id = ? and class_id = ?
                        `, [week_result[i].week, class_id], (err2, attendance_result) => {
                            if (err2) {
                                console.error(err2);
                                throw err2;
                            }



                            for (let j = 0; j < attendance_result.length; j++) {
                                if (attendance_result[j].record == '출석') {
                                    attendance_count++;
                                } else if (attendance_result[j].record == '지각') {
                                    late_count++;
                                } else if (attendance_result[j].record == '결석') {
                                    absent_count++;
                                }
                            }
                            week_object = {
                                week: week_result[i].week,
                                day: getDate(week_result[i].class_day),
                                time: week_result[i].class_time,
                                attendance_count,
                                late_count,
                                absent_count
                            }
                            result_arr.push(week_object);

                            attendance_count = 0;
                            late_count = 0;
                            absent_count = 0;

                            if (i == week_result.length - 1) {
                                //jwt 생성 후 전송
                                let newToken = jwt.sign(
                                    { logId: decoded.logId },
                                    secretObj.secret,
                                    { expiresIn: '5h' }
                                )

                                let result10 = {
                                    result_arr,
                                    error: false,
                                    message: "잘 보내짐",
                                    token: newToken
                                }
                                res.json(result10)
                            }
                        })
                    }
                }
            })
        }
    })
})

// 4-2. 교수 출결 수정, 교수가 수동으로 출석 변경
router.put('/', (req, res) => {
    let token = req.headers['x-access-token'] || req.query.token;
    let {
        att_id,
        record,
        reason
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
        let update_date = makeUpdateTime();
        connection.query(`
            update attendance
            set record = ?, reason = ?, is_verified = 1, updated_day = ?, updated_time = ?
            where id = ?
        `, [record, reason, new Date(), update_date, att_id], (err1, result1) => {
            if (err1) throw err1;

            //jwt 생성 후 전송
            let newToken = jwt.sign(
                { logId: decoded.logId },
                secretObj.secret,
                { expiresIn: '5m' }
            )

            res.json({
                error: false,
                message: "특정 출결 변경이 성공했습니다.",
                token: newToken
            })
        })

    })
})

module.exports = router;


function getDate(date) {
    let year = date.getUTCFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();

    let result = (year + "-" + month + "-" + day)

    return result;
}

function makeUpdateTime() {
    let hour = new Date().getHours();
    let minute = new Date().getMinutes();

    return (hour * 60)+minute;
}