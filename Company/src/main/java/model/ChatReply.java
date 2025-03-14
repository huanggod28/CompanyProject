package model;

import java.sql.Timestamp;

public class ChatReply {
	private Integer id;
    private Integer messageId;
    private Integer userId;
    private String name;
    private String content;
    private Timestamp createdAt;
	
    public ChatReply() {
		super();
	}
	public ChatReply(Integer id, Integer messageId, Integer userId, String name, String content, Timestamp createdAt) {
		super();
		this.id = id;
		this.messageId = messageId;
		this.userId = userId;
		this.name = name;
		this.content = content;
		this.createdAt = createdAt;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getMessageId() {
		return messageId;
	}
	public void setMessageId(Integer messageId) {
		this.messageId = messageId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
    
    
}
