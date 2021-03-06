package com.member.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class MemberService {
	
	private MemberDAO_interface dao;
	
	public MemberService() {
		dao = new MemberDAO();
	}
	
	public MemberVO insertMember(String account, String pwd, String nickName, String userName, String gender, Date birthDate, String phone, 
					String certification, byte[] certificationPic, String personID, String address, byte[] personPhoto) {
		MemberVO vo = new MemberVO();
		vo.setAccount(account);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setUserName(userName);
		vo.setGender(gender);
		vo.setBirthDate(birthDate);
		vo.setPhone(phone);
		vo.setCertification(certification);
		vo.setCertificationPic(certificationPic);
		vo.setPersonID(personID);
		vo.setAddress(address);
		vo.setPersonPhoto(personPhoto);
		dao.insert(vo);
		return vo;
	}
	
	public MemberVO updateMember(Integer userID, String account, String nickName, String userName, 
								String gender, Date birthDate, String phone, String certification, byte[] certificationPic, 
								String personID, String address, Timestamp createTime, Integer status, Timestamp upDateTime,
								Integer ratePeople, Integer ratePoint, byte[] personPhoto) {
		MemberVO vo = new MemberVO();
		vo.setUserID(userID);
		vo.setAccount(account);
		vo.setNickName(nickName);
		vo.setUserName(userName);
		vo.setGender(gender);
		vo.setBirthDate(birthDate);
		vo.setPhone(phone);
		vo.setCertification(certification);
		vo.setCertificationPic(certificationPic);
		vo.setPersonID(personID);
		vo.setAddress(address);
		vo.setCreateTime(createTime);
		vo.setStatus(status);
		vo.setUpDateTime(upDateTime);
		vo.setRatePeople(ratePeople);
		vo.setRatePoint(ratePoint);
		vo.setPersonPhoto(personPhoto);
		dao.update(vo);
		return vo;
	}
	
	public MemberVO getone(Integer userID) {
		return dao.findByPrimaryKey(userID);
	}
	
	public MemberVO findByAccount(String account){
		return dao.findByAccount(account);
	}
	
	public List<MemberVO> getAll(){
		return dao.getAll();
	}
	
	public Boolean loginMember(String account, String pwd) {
		MemberVO vo = new MemberVO();
		vo.setAccount(account);
		vo.setPwd(pwd);
//		dao.login(vo);
//		return vo;
		return dao.login(vo);
	}
	
	public Boolean checkAccountMember(String account) {
		MemberVO vo = new MemberVO();
		vo.setAccount(account);
		return dao.checkAccount(vo);
	}
	
	public MemberVO persoInfoUpdateMember(Integer userID, String nickName, String userName, 
			String gender, Date birthDate, String phone, String certification,
			byte[] certificationPic, String personID, String address, byte[] personPhoto) {
		MemberVO vo = new MemberVO(); 
		
		vo.setUserID(userID);
		vo.setNickName(nickName);
		vo.setUserName(userName);
		vo.setGender(gender);
		vo.setBirthDate(birthDate);
		vo.setPhone(phone);
		vo.setCertification(certification);
		vo.setCertificationPic(certificationPic);
		vo.setPersonID(personID);
		vo.setAddress(address);
		vo.setPersonPhoto(personPhoto);
		
		dao.personInfoUpdate(vo);
		return vo;}
	public void ForgetPwd(String account, String pwd) {
		dao.updatePassword(account, pwd);
	}
	
	public MemberVO pwdUpdateMember(Integer userID, String pwd) {
		MemberVO vo = new MemberVO();
		vo.setUserID(userID);
		vo.setPwd(pwd);
		dao.pwdUpdate(vo);
		return vo;
	}
	
	public List<MemberVO> findBySearchMember(String account, String nickName, String userName){
		return dao.findBySearch(account, nickName, userName);
	}
	
	public List<MemberVO> managerFindBySearch(String account, String nickName, String userName, String address){
		return dao.managerFindBySearch(account, nickName, userName, address);
	}
}
