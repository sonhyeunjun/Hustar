function fn_submit() {


	let userid = document.frm.userid.value;
	let len = userid.length;
	for (let i = 0; i < len; i++) {
		// 치환 replace(old,new)
		userid = userid.replace(" ", "");
	}

	if (userid.length < 4 || userid.length > 12) {
		alert("아이디를 다시 입력해 주세요.");
		document.frm.userid.focus();
		return false;
	}
	if (document.frm.pass.value == "") {
		alert("암호를 입력해 주세요.");
		document.frm.pass.focus();
		return false;
	}
	if (document.frm.name.value == "") {
		alert("이름을 입력해 주세요.");
		document.frm.name.focus();
		return false;
	}
	if (document.frm.brithday.value == "") {
		alert("생일을 입력해 주세요.");
		document.frm.brithday.focus();
		return false;
	}
	if (document.frm.phone.value == "") {
		alert("폰 번호을 입력해 주세요.");
		document.frm.brithday.focus();
		return false;
	}
	document.frm.submit(); // 전송
}
