package POJO;

import java.io.File;
import org.springframework.web.multipart.MultipartFile;

public class ExcelUploadObject {
	
	private String streamName;
	private String location;
	private String site;
	private MultipartFile file;
	
	
	
	public ExcelUploadObject(String streamName, String location, String site, MultipartFile file) {
		super();
		this.streamName = streamName;
		this.location = location;
		this.site = site;
		this.file = file;
	}
	
	
	public ExcelUploadObject() {
		super();

	}


	public String getStreamName() {
		return streamName;
	}
	public void setStreamName(String streamName) {
		this.streamName = streamName;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getSite() {
		return site;
	}
	public void setSite(String site) {
		this.site = site;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}


	@Override
	public String toString() {
		return "ExcelUploadObject [streamName=" + streamName + ", location=" + location + ", site=" + site + ", file="
				+ file + "]";
	}
	
	
	

}
