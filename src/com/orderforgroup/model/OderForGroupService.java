package com.orderforgroup.model;

import java.sql.Date;
import java.util.List;

public class OderForGroupService {
	
	private OderForGroupDAO_interface dao;
	
	public OderForGroupService() {
		dao = new OderForGroupDAO();
	}
	public OderForGroupVO insertOderForGroup(Integer userID, Integer groupTourSN, Integer totalPrice, Date purchaseDate, String phone, String personID, Date birthdate) {
		OderForGroupVO vo = new OderForGroupVO();
		vo.setUserID(userID);
		vo.setGroupTourSN(groupTourSN);
		vo.setTotalPrice(totalPrice);
		vo.setPurchaseDate(purchaseDate);
		vo.setPhone(phone);
		vo.setPersonID(personID);
		vo.setBirthdate(birthdate);
		dao.insert(vo);
		return vo;
	}
	public OderForGroupVO updateOderForGroup(Integer orderSN, Integer userID, Integer groupTourSN, Integer totalPrice, Date purchaseDate, String phone, String personID, Date birthdate) {
		
		OderForGroupVO vo = new OderForGroupVO();
		vo.setOrderSN(orderSN);
		vo.setUserID(userID);
		vo.setGroupTourSN(groupTourSN);
		vo.setTotalPrice(totalPrice);
		vo.setPurchaseDate(purchaseDate);
		vo.setPhone(phone);
		vo.setPersonID(personID);
		vo.setBirthdate(birthdate);
		dao.update(vo);
		return vo;
		
	}
	public OderForGroupVO findByPrimaryKey(Integer orderSN) {
		return dao.findByPrimaryKey(orderSN);
	}
	public List<OderForGroupVO> getOrderByUserID(Integer userID) {
		return dao.getOrderByUserID(userID);
	}
	public List<OderForGroupVO> getAll() {
		return dao.getAll();
	}
	public List<Integer> checkRepeatOrder(Integer userID) {
		return dao.checkRepeatOrder(userID);
	}

}
