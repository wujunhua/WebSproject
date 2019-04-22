package Controller;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import javax.sql.DataSource;
import org.apache.pdfbox.pdmodel.PDPage;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

//pdf-box layout used under MIT license. Found at https://github.com/ralfstuckert/pdfbox-layout
import rst.pdfbox.layout.elements.Document;
import rst.pdfbox.layout.elements.Paragraph;
import rst.pdfbox.layout.elements.VerticalSpacer;
import rst.pdfbox.layout.elements.render.VerticalLayoutHint;
import rst.pdfbox.layout.text.Alignment;
import rst.pdfbox.layout.text.BaseFont;
import rst.pdfbox.layout.elements.ImageElement;

//import org.jfree.chart.ChartUtilities;

public class PDF {
    
    private static DataSource dataSource;
    private NamedParameterJdbcTemplate njdbc;

	private final static BaseFont font = BaseFont.Helvetica;
	private PDPage page = new PDPage();
    private PDFinfo pdfinfo;

	private String filePath = "C:/Users/syntel/Music/"; //use getfilepath in the email logic?
    private final static String imagePath = "C:\\trainingkb\\WebSproject\\web\\resources\\img\\pdf_banner.png"; //path to AS logo

    //java.io.File.separator
    public PDF(){}
    
	public PDF(DataSource dataSource) throws ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        System.out.println("Constructor Called");
        PDF.dataSource=dataSource;
        njdbc = new NamedParameterJdbcTemplate(dataSource);
	}
   
    public void setPdfinfo(PDFinfo pdfinfo) {
        this.pdfinfo = pdfinfo;
    }

    public PDFinfo getPdfinfo() {
        return pdfinfo;
    }
	
    public DataSource getDataSource() {
        return dataSource;
    }

    public NamedParameterJdbcTemplate getNjdbc() {
        return njdbc;
    }

    public void setDataSource(DataSource dataSource) {
        PDF.dataSource = dataSource;
    }

    public void setNjdbc(NamedParameterJdbcTemplate njdbc) {
        this.njdbc = njdbc;
    }
    
	public PDPage getPage() {
		return page;
	}
    
	public void setPage(PDPage page) {
		this.page = page;
	}
 
	public String getFilePath() {
		return filePath;
	}
    
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
    
    public void generate(String empid) throws Exception{
        //init config
        njdbc = new NamedParameterJdbcTemplate(dataSource);
        PDFinfo info = new PDFinfo(dataSource.getConnection());
        info.setDataSource(dataSource);
        info.setNjdbc(njdbc);
        
        String name = info.getEmployeeName(empid);
        
        if(name.equals("")){
            System.out.println("Employee ID not found. PDF has not been generated.");
            return;
        }

        //define output vars
        String gradeNumbers = "Overall Grade: " + info.getAverageScore(empid) + "\n|  ";
        
        ArrayList<String> stream = info.getStreamIDName(empid);
       
        ArrayList<String[]> cats = new ArrayList<String[]>();
        cats.addAll(info.getCategoryNameID());
 
        //define a <hr /> --------------------------------
        char[] charArray = new char[1835];
        Arrays.fill(charArray, ' ');
        String hrHelp = new String(charArray);
        
        Paragraph hRule = new Paragraph();
        hRule.addMarkup("__" + hrHelp + " __", 1, font);
        //------------------------------------------------
        
        //create PDF
        float linspace = 12;
        float sectionBreak = 18;
        float leftMargin = 40;
        float rightMargin = 40;
        float topMargin = 20;
        float bottomMargin = 20;
        Document document = new Document(leftMargin, rightMargin, topMargin, bottomMargin);
        
        document.add(new ImageElement(imagePath), new VerticalLayoutHint(Alignment.Left, 0, 0,
		0, 0, true)); 
        document.add(new VerticalSpacer(100));
              
        Paragraph par = new Paragraph();
        
        par = new Paragraph();
        par.addMarkup("{color:#0066a1}__***PERFORMICA REPORT***__", 20, font);
       	document.add(par, VerticalLayoutHint.CENTER);
        document.add(new VerticalSpacer(sectionBreak));
   
        Paragraph emp = new Paragraph();
        emp.addMarkup( "{color:#0066a1}*NAME*{color:#000000}: " + name + "            " +
                "{color:#0066a1}*EMPLOYEE ID*{color:#000000}: " + empid, 14, font);
        emp.setAlignment(Alignment.Center);
        document.add(emp);
        
        //document.add(new VerticalSpacer(6.5f));
        
        document.add(new VerticalSpacer(2*sectionBreak));
        
        Paragraph p1 = new Paragraph();
        p1.addMarkup("{color:#0066a1}__*My Trainings*__:", 12, font);
        document.add(p1);
        document.add(new VerticalSpacer(linspace));
        
        Paragraph pur = new Paragraph();
        pur.addMarkup("{color:#000000}*Stream*: " + stream.get(0) + " - " + stream.get(1), 12, font);
        document.add(pur);
        document.add(new VerticalSpacer(linspace));
        
        //modules
        document.add(hRule);
        document.add(new VerticalSpacer(linspace));
        for (String[] cat : cats){
            ArrayList<String> scores = new ArrayList<String>();
            scores.addAll(info.getModuleScoresByCategory(empid, cat[1]));
            
            if (scores.size() > 0){
                gradeNumbers += cat[0] + " Grade: " + info.getAverageScoreByCategory(empid, cat[1]) + "  |  ";
                
                document.add(new VerticalSpacer(5));
                par = new Paragraph();

                par.addMarkup("{color:#0066a1}*" + cat[0] + "*{color:#000000}:  ", 11, font);
                for(int i = 0; i < scores.size() - 2; i+=2){
                    par.addMarkup(scores.get(i) + ",  ", 11, font);
                }
                par.addMarkup(scores.get(scores.size() - 2), 11, font);

                document.add(par, VerticalLayoutHint.LEFT);
                document.add(hRule);
                document.add(new VerticalSpacer(linspace));
            }
        }
                
        Paragraph p2 = new Paragraph();
        p2.addMarkup("{color:#0066a1}__*My Performence*__\n\n<<bargraph goes here>>", 12, font); //http://www.java2s.com/Code/Java/Chart/JFreeChartHorizontalBarChartDemo2.htm
        document.add(new VerticalSpacer(linspace));
        document.add(p2);
        document.add(new VerticalSpacer(50));

        Paragraph grades = new Paragraph();
        grades.addMarkup(gradeNumbers, 11, font);
        grades.setAlignment(Alignment.Center);
        document.add(grades);
        document.add(new VerticalSpacer(linspace));
        
        Paragraph quote = new Paragraph();
        quote.addMarkup("{color:#000000}_*\"Learning is the lifelong process of transforming information and experience into knowledge, skills, behaviours and attitudes\"*_\n", 10, font);
        quote.addMarkup(" - Jeff Cobb, _10 Ways to be a Better Learner_", 10, font);
        quote.setAlignment(Alignment.Center);
        document.add(new VerticalSpacer(linspace));
        document.add(quote);
        
        final OutputStream outputStream = new FileOutputStream(empid + ".pdf");
        document.save(outputStream);

	}
}

        /* "Real Way" to underline Do not use - inserts new, completely blank, page before rest of content.
        * Saved for possible later use and as a reminder to not Do The Thing
        Stroke stroke = new Stroke();
        RenderContext rc = new RenderContext(document, document.getPDDocument());
        stroke.applyTo(rc.getContentStream());
        rc.close();
        */