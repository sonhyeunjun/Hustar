function fn_submit() {
	if(document.frm.userid.value == ""){
		alert("이메일를 입력해 주세요.");
		document.frm.userid.focus();
		return false;
	}
	if(document.frm.pass.value == ""){
		alert("비밀번호를 입력해 주세요.");
		document.frm.pass.focus();
		return false;
	}
	document.frm.submit(); // 전송
}

