package com.product.model;

import java.sql.Timestamp;
import java.util.List;

public class ProductService {
	private ProductDAO_interface dao;

	public ProductService() {
		dao = new ProductDAO();
	}

	public ProductVO addProduct(String productClass, String productName, Integer productPrice, Integer productQuantity,
			String productStatus, String productDetail, Timestamp productCreateTime, Boolean productDiscount,
			Boolean productPrime, Integer ratingPoint, Integer ratingNumber) {

		ProductVO productVO = new ProductVO();

		productVO.setProductClass(productClass);
		productVO.setProductName(productName);
		productVO.setProductPrice(productPrice);
		productVO.setProductQuantity(productQuantity);
		productVO.setProductStatus(productStatus);
		productVO.setProductDetail(productDetail);
		productVO.setProductCreateTime(productCreateTime);
		productVO.setProductDiscount(productDiscount);
		productVO.setProductDiscount(productDiscount);
		productVO.setProductPrime(productPrime);
		productVO.setRatingPoint(ratingPoint);
		productVO.setRatingNumber(ratingNumber);
		dao.insert(productVO);

		return productVO;
	}

	public ProductVO offShelf(Integer productSN, String productClass, String productName, Integer productPrice,
			Integer productQuantity, String productStatus, String productDetail, Timestamp productCreateTime,
			Boolean productDiscount, Boolean productPrime, Integer ratingPoint, Integer ratingNumber) {

		ProductVO productVO = new ProductVO();

		productVO.setProductSN(productSN);
		productVO.setProductClass(productClass);
		productVO.setProductName(productName);
		productVO.setProductPrice(productPrice);
		productVO.setProductQuantity(productQuantity);
		productVO.setProductStatus(productStatus);
		productVO.setProductDetail(productDetail);
		productVO.setProductCreateTime(productCreateTime);
		productVO.setProductDiscount(productDiscount);
		productVO.setProductPrime(productPrime);
		productVO.setRatingPoint(ratingPoint);
		productVO.setRatingNumber(ratingNumber);
		dao.offShelf(productVO);

		return productVO;
	}

	public ProductVO updateProduct(Integer productSN, String productClass, String productName, Integer productPrice,
			Integer productQuantity, String productStatus, String productDetail, Timestamp productCreateTime,
			Boolean productDiscount, Boolean productPrime, Integer ratingPoint, Integer ratingNumber) {

		ProductVO productVO = new ProductVO();

		productVO.setProductSN(productSN);
		productVO.setProductClass(productClass);
		productVO.setProductName(productName);
		productVO.setProductPrice(productPrice);
		productVO.setProductQuantity(productQuantity);
		productVO.setProductStatus(productStatus);
		productVO.setProductDetail(productDetail);
		productVO.setProductCreateTime(productCreateTime);
		productVO.setProductDiscount(productDiscount);
		productVO.setProductPrime(productPrime);
		productVO.setRatingPoint(ratingPoint);
		productVO.setRatingNumber(ratingNumber);
		dao.update(productVO);

		return productVO;
	}

	public ProductVO getOneProduct(Integer productSN) {
		return dao.getOneByProductSN(productSN);
	}

	public List<ProductVO> getAll() {
		return dao.getAll();
	}
}