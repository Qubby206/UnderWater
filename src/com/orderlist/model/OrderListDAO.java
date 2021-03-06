package com.orderlist.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class OrderListDAO implements OrderListDAO_interface {

	private static final String INSERT_STMT = "INSERT INTO OrderList (productSN, orderSN, purchaseQuantity,"
			+ "productPrice, rating) VALUES (?, ?, ?, ?, ?)";
	
	private static final String DELETE_STMT = "DELETE FROM OrderList WHERE orderListSN = ?";
	private static final String UPDATE_STMT = "UPDATE OrderList SET productSN = ?, orderSN = ?,"
			+ "purchaseQuantity = ?, productPrice = ? WHERE orderListSN = ?";
	
	private static final String GET_ONE_BY_ORDERLISTSN = "SELECT * FROM OrderList WHERE orderListSN = ?";
	private static final String GET_ALL = "SELECT * FROM OrderList ORDER BY orderListSN";

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/UnderWater");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insert(OrderListVO orderListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, orderListVO.getProductSN());
			pstmt.setInt(2, orderListVO.getOrderSN());
			pstmt.setInt(3, orderListVO.getPurchaseQuantity());
			pstmt.setInt(4, orderListVO.getProductPrice());
			pstmt.setInt(5, orderListVO.getRating());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void delete(Integer orderListSN) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setInt(1, orderListSN);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void update(OrderListVO orderListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setInt(1, orderListVO.getProductSN());
			pstmt.setInt(2, orderListVO.getOrderSN());
			pstmt.setInt(3, orderListVO.getPurchaseQuantity());
			pstmt.setInt(4, orderListVO.getProductPrice());
			pstmt.setInt(5, orderListVO.getOrderListSN());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public OrderListVO getOneByOrderListSN(Integer orderListSN) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderListVO orderListVO = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_ORDERLISTSN);

			pstmt.setInt(1, orderListSN);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderListVO = new OrderListVO();
				orderListVO.setOrderListSN(rs.getInt("orderListSN"));
				orderListVO.setProductSN(rs.getInt("productSN"));
				orderListVO.setOrderSN(rs.getInt("orderSN"));
				orderListVO.setPurchaseQuantity(rs.getInt("purchaseQuantity"));
				orderListVO.setProductPrice(rs.getInt("productPrice"));
				orderListVO.setRating(rs.getInt("rating"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return orderListVO;
	}

	@Override
	public List<OrderListVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderListVO orderListVO = null;
		List<OrderListVO> list = new ArrayList<OrderListVO>();

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderListVO = new OrderListVO();
				orderListVO.setOrderListSN(rs.getInt("orderListSN"));
				orderListVO.setProductSN(rs.getInt("productSN"));
				orderListVO.setOrderSN(rs.getInt("orderSN"));
				orderListVO.setPurchaseQuantity(rs.getInt("purchaseQuantity"));
				orderListVO.setProductPrice(rs.getInt("productPrice"));
				orderListVO.setRating(rs.getInt("rating"));
				list.add(orderListVO);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return list;
	}

	@Override
	public void insertWithOrderForProduct(OrderListVO orderListVO, Connection con) {
		PreparedStatement pstmt = null;

		try {
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, orderListVO.getProductSN());
//			System.out.println(orderListVO.getProductSN());
			
			pstmt.setInt(2, orderListVO.getOrderSN());
//			System.out.println(orderListVO.getOrderSN());
			
			pstmt.setInt(3, orderListVO.getPurchaseQuantity());
//			System.out.println(orderListVO.getPurchaseQuantity());
			
			pstmt.setInt(4, orderListVO.getProductPrice());
//			System.out.println(orderListVO.getProductPrice());
			
			pstmt.setInt(5, 0);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			if (con != null) {
				try {
					con.rollback();
				} catch (SQLException e1) {
					throw new RuntimeException("rollback error occured. " + e1.getMessage());

				}
			}
			
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
			
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
