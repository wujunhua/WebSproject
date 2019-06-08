package com.atossyntel.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;

import com.atossyntel.excelupload.ExcelPuller;
import com.atossyntel.excelupload.Runner;
import com.atossyntel.pojo.ExcelUploadObject;

public class UploadAuthentication extends SimpleFormController {

    public UploadAuthentication() {
        setCommandClass(ExcelUploadObject.class);
        setCommandName("excel");
    }

    @Override
    protected ModelAndView onSubmit(Object command) throws Exception {
        ExcelUploadObject excel = (ExcelUploadObject) command;

        try {
            MultipartFile multiFile = excel.getFile();

            File file = convert(multiFile);

            Runner.excelUpload(file, excel.getLocation(), excel.getSite(), excel.getStreamName(), excel.getInsEmail(), excel.getStartDate(), excel.getEndDate());
            // bring in all streams

            ExcelPuller excelPuller = new ExcelPuller();
            String classID = excelPuller.generateClassID(excel.getLocation(), excel.getSite(), excel.getStreamName());

            RedirectView emailSearchView = getEmailClassSearchView(classID);

            return new ModelAndView(emailSearchView);

        } catch (IOException e) {
            return new ModelAndView("uploadErrorPage");
        }

    }

    public File convert(MultipartFile file) throws IOException {
        File convFile = new File(file.getOriginalFilename());
        if (convFile.createNewFile()) {
            try (FileOutputStream fos = new FileOutputStream(convFile)) {
                fos.write(file.getBytes());
            }
        }

        return convFile;
    }

    private RedirectView getEmailClassSearchView(String classID) {

        String searchEmailsUrl = "searchEmailEmployees.htm?col=classID&search=" + classID;

        return new RedirectView(searchEmailsUrl);
    }

}
