package com.shoppingcar.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.orderforproduct.model.OrderForProductService;
import com.orderlist.model.OrderListVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;

@WebServlet("/mall/shoppingCar.html")
public class ShoppingCar extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("30");
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		
		Vector<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingcart");
		String action = request.getParameter("action");
		Integer totalprice = 0;
		
		if (action.equals("createOrder")) {
			OrderForProductService orderSvc = new OrderForProductService();
			
//			System.out.println("44");
				Integer userID = (Integer)(session.getAttribute("userID"));
				
//				System.out.println(request.getParameter("Price"));
				
				Double price = Double.parseDouble(request.getParameter("Price"));
				totalprice = price.intValue();
							
				java.sql.Timestamp purchaseDate = new java.sql.Timestamp(System.currentTimeMillis());
				String orderStatus = "處理中";
				
				List<OrderListVO> list = new ArrayList<OrderListVO>();
//				OrderListVO orderListVO = new OrderListVO(); // 錯誤 : 只給一個址, 資料會被後面新資料覆蓋

				for(ProductVO productVO : buylist) {
					OrderListVO orderListVO = new OrderListVO(); // 正確: 一筆資料給一個地址去存
					
					orderListVO.setProductSN(productVO.getProductSN());
					orderListVO.setPurchaseQuantity(productVO.getProductQuantity());
					orderListVO.setProductPrice(productVO.getProductPrice());
					
//					System.out.println(productVO.getProductSN());
//					System.out.println(productVO.getProductQuantity());
//					System.out.println(productVO.getProductPrice());
					
					list.add(orderListVO);
					
//					System.out.println(orderListVO.getProductSN()+ "+" + orderListVO.getPurchaseQuantity()+ "+" +orderListVO.getProductPrice()+ "+" +totalPrice + "+" + orderStatus );
				}
				
//				for(OrderListVO orderList1VO : list) {
//					System.out.println("=============");
//					System.out.println(orderList1VO.getProductSN());
//					System.out.println(orderList1VO.getPurchaseQuantity());
//					System.out.println(orderList1VO.getProductPrice());
//				}
//				System.out.println("80");
				orderSvc.insertOrder(userID, purchaseDate, totalprice, orderStatus, list);
				
				String url = request.getContextPath()+"/product/ft_listAllProduct.jsp";
				session.removeAttribute("shoppingcart");
				response.sendRedirect(url);
				return;
			}
		
		if (!action.equals("CHECKOUT")) {
//			System.out.println("90");
			
			// 刪除購物車中的商品
			if (action.equals("DELETE")) {
				String del = request.getParameter("del");
				int d = Integer.parseInt(del);
				buylist.removeElementAt(d);
				
				String url = "/shoppingCar/Cart.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
				return;
			}
			// 新增商品至購物車中
			else if (action.equals("ADD")) {
				boolean match = false;

				// 取得後來新增的商品
				ProductVO newproductVO = getProductVO(request);

				// 新增第一項商品至購物車時
				if (buylist == null) {
					buylist = new Vector<ProductVO>();
					buylist.add(newproductVO);
				} else {
					for (int i = 0; i < buylist.size(); i++) {
						ProductVO productVO = buylist.get(i);

						// 假若新增的商品和購物車的商品一樣時
						if (productVO.getProductName().equals(newproductVO.getProductName())) {
							productVO.setProductQuantity(productVO.getProductQuantity()
									+ newproductVO.getProductQuantity());
							buylist.setElementAt(productVO, i);
							match = true;
						}
					}

					// 假若新增的商品和購物車的商品不一樣時
					if (!match)
						buylist.add(newproductVO);
				}
			}
//			System.out.println("132");
			
			session.setAttribute("shoppingcart", buylist);
			String url = "/product/ft_listAllProduct.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
//			System.out.println("138");
		}
		
		// 結帳，計算購物車商品價錢總數
		else if (action.equals("CHECKOUT")) {
//			System.out.println("143");
			
			float total = 0;
			for (int i = 0; i < buylist.size(); i++) {
				ProductVO order = buylist.get(i);
				float price = order.getProductPrice();
				int quantity = order.getProductQuantity();
				total += (price * quantity);
			}

			String amount = String.valueOf(total);
			session.setAttribute("amount", amount);
			String url = "/shoppingCar/Checkout.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
		}
//		System.out.println("159");
	}

	private ProductVO getProductVO(HttpServletRequest request) {
		
		ProductService proSvc = new ProductService();
		
		Integer productSN = new Integer (request.getParameter("productSN").trim());
		Integer productQuantity = new Integer (request.getParameter("productQuantity").trim());
		
		ProductVO productVO = proSvc.getOneProduct(productSN);		
		productVO.setProductQuantity(productQuantity);
				
		return productVO;
	}

}
