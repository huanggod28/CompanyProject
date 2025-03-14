package model;

import java.sql.Timestamp;
import java.util.List;

public class ChatMessage {
	private Integer id;
    private Integer userId;
    private String name;
    private String subject;
    private String content;
    private Timestamp createdAt;
    private List<ChatReply> replies;
    
    public ChatMessage() {
		super();
	}
    
	public ChatMessage(Integer id, Integer userId, String name, String subject, String content, Timestamp createdAt) {
		super();
		this.id = id;
		this.userId = userId;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.createdAt = createdAt;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	 // ✅ 新增回覆 Getter & Setter
    public List<ChatReply> getReplies() { return replies; }
    public void setReplies(List<ChatReply> replies) { this.replies = replies; }
}
