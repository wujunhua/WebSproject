package com.atossyntel.controller;

import java.awt.Color;
import java.util.List;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import javax.sql.DataSource;
import org.apache.log4j.Logger;
import org.apache.pdfbox.pdmodel.PDPage;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.StandardBarPainter;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.TextAnchor;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

//pdf-box layout used under MIT license. Found at https://github.com/ralfstuckert/pdfbox-layout
import rst.pdfbox.layout.elements.Document;
import rst.pdfbox.layout.elements.Paragraph;
import rst.pdfbox.layout.elements.VerticalSpacer;
import rst.pdfbox.layout.elements.render.VerticalLayoutHint;
import rst.pdfbox.layout.text.Alignment;
import rst.pdfbox.layout.text.BaseFont;
import rst.pdfbox.layout.elements.ImageElement;

public class PDF {
static final Logger logger = Logger.getLogger(PDF.class);
    private DataSource dataSource;
    private NamedParameterJdbcTemplate njdbc;

    private DefaultCategoryDataset dataset;

    private static final BaseFont font = BaseFont.Helvetica;
    private PDPage page = new PDPage();
    private PDFinfo pdfinfo;
    static PropertiesAccessor prop = new PropertiesAccessor();
    private String filePath = prop.getFilePath(); //use getfilepath in the email logic?
    private static final String IMAGEPATH = prop.getImagePath(); //path to AS logo

    //java.io.File.separator
    public PDF() {
        this.dataset = new DefaultCategoryDataset();
    }

    public PDF(DataSource dataSource) {
        logger.info(System.getProperty("user.dir"));
        this.dataset = new DefaultCategoryDataset();
        logger.info("Constructor Called");
        this.dataSource = dataSource;
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
        this.dataSource = dataSource;
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

    public void generate(String empid) throws SQLException, IOException {
        //init config
        dataset = new DefaultCategoryDataset();
        njdbc = new NamedParameterJdbcTemplate(dataSource);
        PDFinfo info = new PDFinfo(dataSource.getConnection());
        info.setDataSource(dataSource);
        info.setNjdbc(njdbc);

        String name = info.getEmployeeName(empid);

        if (name.equals("")) {
            logger.error("Employee ID not found. PDF has not been generated.");
            return;
        }

        //define output vars
        StringBuilder gradeNumbers = new StringBuilder("Overall Grade: " + numToLetter(info.getAverageScore(empid)) + "\n|  ");

        List<String> stream = info.getStreamIDName(empid);

        List<String[]> cats = new ArrayList<>();
        cats.addAll(info.getCategoryNameID());

        //define a <hr /> --------------------------------
        char[] charArray = new char[1835];
        Arrays.fill(charArray, ' ');
        String hrHelp = new String(charArray);

        Paragraph hRule = new Paragraph();
        hRule.addMarkup("__" + hrHelp + " __", 1, font);
        //------------------------------------------------

        //create PDF
        float linspace = 10;
        float sectionBreak = 15;
        float textSize = 10;
        float leftMargin = 40;
        float rightMargin = 40;
        float topMargin = 20;
        float bottomMargin = 20;
        Document document = new Document(leftMargin, rightMargin, topMargin, bottomMargin);

        document.add(new ImageElement(IMAGEPATH), new VerticalLayoutHint(Alignment.Left, 0, 0,
                0, 0, true));
        document.add(new VerticalSpacer(90));

        document.add(new ImageElement("C:\\Examples\\WebSproject\\src\\main\\java\\com.atossyntel.controller\\performica.PNG"), new VerticalLayoutHint(Alignment.Left, 0, 0,
                0, 0, true));
        document.add(new VerticalSpacer(50)); //font: Vivaldi

        Paragraph par;

        par = new Paragraph();
        par.addMarkup("{color:#0066a1}*NAME*{color:#000000}: " + name + "                            "
                + "{color:#0066a1}*EMPLOYEE ID*{color:#000000}: " + empid, 13, font);
        par.setAlignment(Alignment.Center);
        document.add(par);
        document.add(hRule);
        document.add(hRule);

        document.add(new VerticalSpacer(sectionBreak));

        par = new Paragraph();
        par.addMarkup("{color:#0066a1}__*My Training*__:  ", textSize + 1, font);
        document.add(par);
        document.add(new VerticalSpacer(0.25f * linspace));

        par = new Paragraph();
        par.addMarkup("{color:#000000}*Stream*: " + stream.get(1), textSize + 1, font);
        document.add(par);
        document.add(new VerticalSpacer(1.5f * linspace));

        document.add(new VerticalSpacer(linspace));
        for (String[] cat : cats) {
            List<String[]> scores = new ArrayList<>();
            scores.addAll(info.getModuleScoresByCategory(empid, cat[1]));

            if (scores.isEmpty()) {
                gradeNumbers.append(cat[0] + " Grade: " + numToLetter(info.getAverageScoreByCategory(empid, cat[1])) + "  |  ");

                par = new Paragraph();
                par.addMarkup("{color:#0066a1}*" + cat[0] + "*{color:#000000}:  ", textSize, font);

                par.addMarkup("|", textSize, font);
                for (String[] score : scores) {
                    par.addMarkup("  " + score[0] + "  |", textSize, font);
                    String classScore = info.getClassModuleScores(empid, score[0]);
                    //set up for chart: add number, series label, bar label
                    dataset.addValue(Float.parseFloat(score[1]), name, score[0]);
                    dataset.addValue(Float.parseFloat(classScore), "Class Average", score[0]);
                }

                document.add(par, VerticalLayoutHint.LEFT);
                document.add(new VerticalSpacer(1.5f * linspace));
            }
        }

        par = new Paragraph();
        par.addMarkup("{color:#0066a1}__*My Performance*__:", textSize + 1, font);
        document.add(new VerticalSpacer(linspace));
        document.add(par);

        String chartFileName = "graph.png";
        makeChart(dataset, chartFileName);
        document.add(new ImageElement(chartFileName), new VerticalLayoutHint(Alignment.Left, 0, 0,
                0, 0, true));

        document.add(new VerticalSpacer(285));

        char[] array = new char[1050];
        Arrays.fill(array, ' ');
        String line = new String(array);

        par = new Paragraph();
        par.addMarkup("__" + line + "__\n", 1, font);
        par.addMarkup("|  Grade Range  |  > 90.00  |  80.00 - 89.99  |  70.00 - 79.99 | < 70  |\n", textSize, font);
        par.addMarkup("__" + line + "__\n", 1, font);
        par.addMarkup("|   Letter Grade   |       A       |           B            |           C          |    F    |\n", textSize, font);
        par.addMarkup("__" + line + "__", 1, font);

        par.setAlignment(Alignment.Center);
        document.add(par);
        document.add(new VerticalSpacer(sectionBreak));

        par = new Paragraph();
        par.addMarkup(gradeNumbers.toString(), textSize, font);
        par.setAlignment(Alignment.Center);
        document.add(par);
        document.add(new VerticalSpacer(linspace));

        par = new Paragraph();
        par.addMarkup("{color:#000000}_*\"Learning is the lifelong process of transforming information and experience into knowledge, skills, behaviours and attitudes\"*_\n", 10, font);
        par.addMarkup(" - Jeff Cobb, _10 Ways to be a Better Learner_", textSize - 2, font);
        par.setAlignment(Alignment.Center);
        document.add(new VerticalSpacer(linspace));
        document.add(par);
        document.add(hRule);

        final OutputStream outputStream = new FileOutputStream(filePath + empid + ".pdf");
        document.save(outputStream);
        logger.info("Saved file to:" + filePath + empid + ".pdf");

    }

    public static void makeChart(DefaultCategoryDataset dataset, String filename) {
        JFreeChart barChart = ChartFactory.createBarChart(
                "",
                "", "",
                //"Module", "Assessment Score", 
                dataset, PlotOrientation.VERTICAL,
                true, true, false);
        CategoryPlot plot = barChart.getCategoryPlot();
        plot.setBackgroundPaint(null);
        plot.setDomainGridlinePaint(Color.black);
        plot.setRangeGridlinePaint(Color.black);

        ValueAxis yAxis = plot.getRangeAxis();
        yAxis.setAutoRange(false);
        yAxis.setRange(0.00, 100.00);

        CategoryAxis axis = plot.getDomainAxis();
        axis.setLowerMargin(.01);
        axis.setUpperMargin(.01);
        axis.setMaximumCategoryLabelLines(3);

        BarRenderer renderer = (BarRenderer) plot.getRenderer();
        renderer.setBarPainter(new StandardBarPainter());
        renderer.setSeriesPaint(0, new Color(0, 102, 161)); //from website
        renderer.setSeriesPaint(1, new Color(106, 206, 242));  //from banner
        renderer.setShadowVisible(false);
        renderer.setDrawBarOutline(false);
        renderer.setItemMargin(0.0); //space between bars
        renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
        renderer.setBaseItemLabelsVisible(true);
        renderer.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.OUTSIDE9, TextAnchor.BASELINE_LEFT));

        int width = 525;
        /* Width of the image */
        int height = 275;
        /* Height of the image */
        File secondBarChart = new File(filename);
        try {
            ChartUtilities.saveChartAsJPEG(secondBarChart, barChart, width, height);
        } catch (IOException ex) {
            logger.error("Cannot save chart:\n" + ex.toString());
        }
    }

    private char numToLetter(String n) {
        float num = Float.parseFloat(n);
        if (num >= 90f) {
            return 'A';
        } else if (num >= 80f) {
            return 'B';
        } else if (num >= 70f) {
            return 'C';
        } else {
            return 'F';
        }
    }
}
/* "Real Way" to underline Do not use - inserts new, completely blank, page before rest of content.
//Saved for possible later use and as a reminder to not Do The Thing
 */
