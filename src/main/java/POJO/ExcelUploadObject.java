
package POJO;

import java.io.File;
import org.springframework.web.multipart.MultipartFile;

public class ExcelUploadObject {
	
	private String streamName;
	private String location;
	private String site;
        private MultipartFile file;
	private String insEmail;
        private String startDate;
        private String endDate;

    public ExcelUploadObject(String streamName, String location, String site, MultipartFile file, String insEmail, String startDate, String endDate) {
        this.streamName = streamName;
        this.location = location;
        this.site = site;
        this.file = file;
        this.insEmail = insEmail;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public ExcelUploadObject() {
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

    public String getInsEmail() {
        return insEmail;
    }

    public void setInsEmail(String insEmail) {
        this.insEmail = insEmail;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
        


	
	

}

