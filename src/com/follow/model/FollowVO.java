package com.follow.model;

public class FollowVO implements java.io.Serializable{
	private Integer follower;//粉絲
	private Integer followed;//明星
	public Integer getFollower() {
		return follower;
	}
	public void setFollower(Integer follower) {
		this.follower = follower;
	}
	public Integer getFollowed() {
		return followed;
	}
	public void setFollowed(Integer followed) {
		this.followed = followed;
	}

}
