//Poll Insert: 새로운 설문지를 생성
	public boolean insertPoll(PollListBean plBean, PollItemBean piBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblPollList(question, sdate, edate, wdate, type)"
					+"values(?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, plBean.getQuestion());
			pstmt.setString(2, plBean.getSdate());
			pstmt.setString(3, plBean.getEdate());
			pstmt.setInt(4, plBean.getType()); //1: 복수 설문, 0: 단일설문
			int cnt = pstmt.executeUpdate();
			pstmt.close();
			if(cnt==1) { //정상적으로 설문리스트를 저장 -> 설문아이템 저장
				sql = "insert tblPollItem values(?,?,?,0)";
				pstmt = con.prepareStatement(sql);
				int listNum = getMaxNum(); //방금 저장된 listNum 값 리턴
				String item[] = piBean.getItem();
				int j = 0;
				for(int i = 0; i<item.length; i++) {
					if(item[i]==null||item[i].trim().equals("")) {
						break;
					}
					pstmt.setInt(1, listNum);
					pstmt.setInt(2, i);
					pstmt.setString(3, item[i]);
					j=pstmt.executeUpdate();
				}//--for
				if(j==1)flag = true;
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}