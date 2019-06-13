const utils = require("./utils.js");
const tests = {};
tests["Admin login success does have instructor tab"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.form-group:nth-child(4) > .btn`)), configuration.timeout);
  await driver.findElement(By.css(`.form-group:nth-child(4) > .btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Admin`)), configuration.timeout);
  await expect(driver.findElements(By.linkText(`Admin`))).resolves.toBePresent();
}
tests["Instructor login success does not have admin tab"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`IN1@syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`KB1234`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.form-group:nth-child(4) > .btn`)), configuration.timeout);
  await driver.findElement(By.css(`.form-group:nth-child(4) > .btn`)).then(element => {
    return element.click();
  });
  await expect(driver.findElements(By.linkText(`Admin`))).resolves.not.toBePresent();
}
tests["Admin switch view (from admin to instructor)"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.form-group:nth-child(4) > .btn`)), configuration.timeout);
  await driver.findElement(By.css(`.form-group:nth-child(4) > .btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Admin`)), configuration.timeout);
  await expect(driver.findElements(By.linkText(`Admin`))).resolves.toBePresent();
  await driver.wait(until.elementLocated(By.linkText(`Instructor`)), configuration.timeout);
  await driver.findElement(By.linkText(`Instructor`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.navbar-nav > .nav-item:nth-child(1) > .nav-link`)), configuration.timeout);
  await driver.findElement(By.css(`.navbar-nav > .nav-item:nth-child(1) > .nav-link`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Instructor`)), configuration.timeout);
  await driver.findElement(By.linkText(`Instructor`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.navbar-nav > .nav-item:nth-child(1) > .nav-link`)), configuration.timeout);
  await driver.findElement(By.css(`.navbar-nav > .nav-item:nth-child(1) > .nav-link`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Instructor`)), configuration.timeout);
  await expect(driver.findElements(By.linkText(`Instructor`))).resolves.toBePresent();
}
tests["Admin login; Insert, update and delete streams"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`streamName`)), configuration.timeout);
  await driver.findElement(By.id(`streamName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`streamName`)), configuration.timeout);
  await driver.findElement(By.id(`streamName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`ReactJS`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn-primary`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-primary`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`ReactJS`)), configuration.timeout);
  await driver.findElement(By.linkText(`ReactJS`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`new_stream_name`)), configuration.timeout);
  await driver.findElement(By.id(`new_stream_name`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`new_stream_name`)), configuration.timeout);
  await driver.findElement(By.id(`new_stream_name`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`React.JS`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn-secondary > span`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-secondary > span`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`React.JS`)), configuration.timeout);
  await driver.findElement(By.linkText(`React.JS`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.btn-danger > span`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-danger > span`)).then(element => {
    return element.click();
  });
}
tests["Admin login; Insert, update and delete category"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Category`)), configuration.timeout);
  await driver.findElement(By.linkText(`Category`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`categoryName`)), configuration.timeout);
  await driver.findElement(By.name(`categoryName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`categoryName`)), configuration.timeout);
  await driver.findElement(By.name(`categoryName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Simulation`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn-primary`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-primary`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Simulation`)), configuration.timeout);
  await driver.findElement(By.linkText(`Simulation`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.form-group`)), configuration.timeout);
  await driver.findElement(By.css(`.form-group`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`new_category_name`)), configuration.timeout);
  await driver.findElement(By.id(`new_category_name`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Presentation`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn-secondary`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-secondary`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Presentation`)), configuration.timeout);
  await driver.findElement(By.linkText(`Presentation`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.btn-danger`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-danger`)).then(element => {
    return element.click();
  });
}
tests["Admin Switch views (admin and instructor)"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.manage().window().setRect({
    width: 1378,
    height: 744
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Instructor`)), configuration.timeout);
  await driver.findElement(By.linkText(`Instructor`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.navbar-nav > .nav-item:nth-child(1) > .nav-link`)), configuration.timeout);
  await driver.findElement(By.css(`.navbar-nav > .nav-item:nth-child(1) > .nav-link`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.btn > small`)), configuration.timeout);
  await driver.findElement(By.css(`.btn > small`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Logout`)), configuration.timeout);
  await driver.findElement(By.linkText(`Logout`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Pat`);
    });
  });
}
tests["Admin login; Insert, update and delete modules"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Modules`)), configuration.timeout);
  await driver.findElement(By.linkText(`Modules`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`modName`)), configuration.timeout);
  await driver.findElement(By.id(`modName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`modName`)), configuration.timeout);
  await driver.findElement(By.id(`modName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`modName`)), configuration.timeout);
  await driver.findElement(By.id(`modName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`CSS`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn-primary`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-primary`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`CSS`)), configuration.timeout);
  await driver.findElement(By.linkText(`CSS`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`modName`)), configuration.timeout);
  await driver.findElement(By.id(`modName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`modName`)), configuration.timeout);
  await driver.findElement(By.id(`modName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`CSS3`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn-secondary > span`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-secondary > span`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`CSS3`)), configuration.timeout);
  await driver.findElement(By.linkText(`CSS3`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.btn-danger > span`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-danger > span`)).then(element => {
    return element.click();
  });
}
tests["Admin login; Insert, update and delete courses"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.manage().window().setRect({
    width: 1366,
    height: 728
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Courses`)), configuration.timeout);
  await driver.findElement(By.linkText(`Courses`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`coursename`)), configuration.timeout);
  await driver.findElement(By.id(`coursename`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`coursename`)), configuration.timeout);
  await driver.findElement(By.id(`coursename`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`RWD`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`modulename`)), configuration.timeout);
  await driver.findElement(By.id(`modulename`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`modulename`)), configuration.timeout);
  await driver.findElement(By.id(`modulename`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.btn-primary`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-primary`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`RWD`)), configuration.timeout);
  await driver.findElement(By.linkText(`RWD`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`new_course_name`)), configuration.timeout);
  await driver.findElement(By.id(`new_course_name`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`new_course_name`)), configuration.timeout);
  await driver.findElement(By.id(`new_course_name`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`HTML`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn-secondary > span`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-secondary > span`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`HTML`)), configuration.timeout);
  await driver.findElement(By.linkText(`HTML`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.btn-danger > span`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-danger > span`)).then(element => {
    return element.click();
  });
}
tests["Admin login; Insert, update and delete user (admin & instructor)"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.manage().window().setRect({
    width: 1366,
    height: 728
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Users`)), configuration.timeout);
  await driver.findElement(By.linkText(`Users`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`username`)), configuration.timeout);
  await driver.findElement(By.id(`username`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`username`)), configuration.timeout);
  await driver.findElement(By.id(`username`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Test_Test1@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.mt-1`)), configuration.timeout);
  await driver.findElement(By.css(`.mt-1`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Test_Test1@Syntelinc.com`)), configuration.timeout);
  await driver.findElement(By.linkText(`Test_Test1@Syntelinc.com`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`inputEmail3`)), configuration.timeout);
  await driver.findElement(By.id(`inputEmail3`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`inputEmail3`)), configuration.timeout);
  await driver.findElement(By.id(`inputEmail3`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Test_Test@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn-secondary > span`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-secondary > span`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Test_Test@Syntelinc.com`)), configuration.timeout);
  await driver.findElement(By.linkText(`Test_Test@Syntelinc.com`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.btn-danger > span`)), configuration.timeout);
  await driver.findElement(By.css(`.btn-danger > span`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.dropdown-toggle`)), configuration.timeout);
  await driver.findElement(By.css(`.dropdown-toggle`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Logout`)), configuration.timeout);
  await driver.findElement(By.linkText(`Logout`)).then(element => {
    return element.click();
  });
}
tests["Admin login; Switch view to instructor; Create class"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.manage().window().setRect({
    width: 1366,
    height: 728
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Instructor`)), configuration.timeout);
  await driver.findElement(By.linkText(`Instructor`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`streamName`)), configuration.timeout);
  await driver.findElement(By.name(`streamName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`location`)), configuration.timeout);
  await driver.findElement(By.id(`location`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`location`)), configuration.timeout);
  await driver.findElement(By.id(`location`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`USA`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`insEmail`)), configuration.timeout);
  await driver.findElement(By.id(`insEmail`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`insEmail`)), configuration.timeout);
  await driver.findElement(By.id(`insEmail`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`katherine_bollinger@syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`startDate`)), configuration.timeout);
  await driver.findElement(By.id(`startDate`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`startDate`)), configuration.timeout);
  await driver.findElement(By.id(`startDate`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`2019-05-01`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`endDate`)), configuration.timeout);
  await driver.findElement(By.id(`endDate`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`endDate`)), configuration.timeout);
  await driver.findElement(By.id(`endDate`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`2019-05-23`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`file`)), configuration.timeout);
  await driver.findElement(By.id(`file`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`file`)), configuration.timeout);
  await driver.findElement(By.id(`file`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`C://Users//syntel//Downloads//FSD123-Template.xlsx`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.row:nth-child(6) > .btn`)), configuration.timeout);
  await driver.findElement(By.css(`.row:nth-child(6) > .btn`)).then(element => {
    return element.click();
  });
}
tests["Admin login; Switch view to instructor; Search and email"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Instructor`)), configuration.timeout);
  await driver.findElement(By.linkText(`Instructor`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Email Hub`)), configuration.timeout);
  await driver.findElement(By.linkText(`Email Hub`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.mr-2`)), configuration.timeout);
  await driver.findElement(By.css(`.mr-2`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`emailChecked`)), configuration.timeout);
  await driver.findElement(By.name(`emailChecked`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.mx-1:nth-child(1)`)), configuration.timeout);
  await driver.findElement(By.css(`.mx-1:nth-child(1)`)).then(element => {
    return element.click();
  });
  await driver.switchTo().alert().then(alert => {
    return alert.getText().then(text => {
      expect(text).toBe(`Email Sent Successfully!`);
      return alert.accept();
    });
  });
}
tests["Admin login; Switch view to instructor; Search employee"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.manage().window().setRect({
    width: 1366,
    height: 728
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jay_Patel@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Instructor`)), configuration.timeout);
  await driver.findElement(By.linkText(`Instructor`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Employees`)), configuration.timeout);
  await driver.findElement(By.linkText(`Employees`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Cook`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.rounded-0`)), configuration.timeout);
  await driver.findElement(By.css(`.rounded-0`)).then(element => {
    return element.click();
  });
}
tests["Instructor login; Create class"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Nicholas_Cook@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`streamName`)), configuration.timeout);
  await driver.findElement(By.name(`streamName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`location`)), configuration.timeout);
  await driver.findElement(By.id(`location`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`location`)), configuration.timeout);
  await driver.findElement(By.id(`location`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`USA`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`insEmail`)), configuration.timeout);
  await driver.findElement(By.id(`insEmail`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`insEmail`)), configuration.timeout);
  await driver.findElement(By.id(`insEmail`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`katherine_bollinger@syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`startDate`)), configuration.timeout);
  await driver.findElement(By.id(`startDate`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`startDate`)), configuration.timeout);
  await driver.findElement(By.id(`startDate`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`startDate`)), configuration.timeout);
  await driver.findElement(By.id(`startDate`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`2019-05-01`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`endDate`)), configuration.timeout);
  await driver.findElement(By.id(`endDate`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`endDate`)), configuration.timeout);
  await driver.findElement(By.id(`endDate`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`2019-05-09`);
    });
  });
  await driver.wait(until.elementLocated(By.id(`file`)), configuration.timeout);
  await driver.findElement(By.id(`file`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.id(`file`)), configuration.timeout);
  await driver.findElement(By.id(`file`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`C://Users//syntel//Downloads//FSD123-Template.xlsx`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.row:nth-child(6) > .btn`)), configuration.timeout);
  await driver.findElement(By.css(`.row:nth-child(6) > .btn`)).then(element => {
    return element.click();
  });
}
tests["Instructor login; Search and email"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.manage().window().setRect({
    width: 1366,
    height: 728
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Nicholas_Cook@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Email Hub`)), configuration.timeout);
  await driver.findElement(By.linkText(`Email Hub`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`J`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`col`)), configuration.timeout);
  await driver.findElement(By.name(`col`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`col`)), configuration.timeout);
  await driver.findElement(By.name(`col`)).then(element => {
    return element.findElement(By.xpath(`//option[. = 'Email']`)).then(option => {
      return option.click();
    });
  });
  await driver.wait(until.elementLocated(By.name(`col`)), configuration.timeout);
  await driver.findElement(By.name(`col`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.mr-2`)), configuration.timeout);
  await driver.findElement(By.css(`.mr-2`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`emailChecked`)), configuration.timeout);
  await driver.findElement(By.name(`emailChecked`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.css(`.mx-1:nth-child(1)`)), configuration.timeout);
  await driver.findElement(By.css(`.mx-1:nth-child(1)`)).then(element => {
    return element.click();
  });
}
tests["Instructor login; Search employee"] = async (driver, vars, opts = {}) => {
  await driver.get("http://localhost:8084/WebSproject/login.htm");
  await driver.manage().window().setRect({
    width: 1366,
    height: 728
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`userName`)), configuration.timeout);
  await driver.findElement(By.name(`userName`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Nicholas_Cook@Syntelinc.com`);
    });
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`password`)), configuration.timeout);
  await driver.findElement(By.name(`password`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`abC1@3deF`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.btn`)), configuration.timeout);
  await driver.findElement(By.css(`.btn`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.linkText(`Employees`)), configuration.timeout);
  await driver.findElement(By.linkText(`Employees`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Jason`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.fa-search`)), configuration.timeout);
  await driver.findElement(By.css(`.fa-search`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`col`)), configuration.timeout);
  await driver.findElement(By.name(`col`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`col`)), configuration.timeout);
  await driver.findElement(By.name(`col`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`col`)), configuration.timeout);
  await driver.findElement(By.name(`col`)).then(element => {
    return element.findElement(By.xpath(`//option[. = 'Email']`)).then(option => {
      return option.click();
    });
  });
  await driver.wait(until.elementLocated(By.name(`col`)), configuration.timeout);
  await driver.findElement(By.name(`col`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.click();
  });
  await driver.wait(until.elementLocated(By.name(`search`)), configuration.timeout);
  await driver.findElement(By.name(`search`)).then(element => {
    return element.clear().then(() => {
      return element.sendKeys(`Anthony`);
    });
  });
  await driver.wait(until.elementLocated(By.css(`.rounded-0`)), configuration.timeout);
  await driver.findElement(By.css(`.rounded-0`)).then(element => {
    return element.click();
  });
}
module.exports = tests;