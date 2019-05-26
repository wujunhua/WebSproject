jest.setMock('selenium-webdriver', webdriver);
// This file was generated using Selenium IDE
const tests = require("./commons.js");
global.Key = require('selenium-webdriver').Key;
global.URL = require('url').URL;
global.BASE_URL = configuration.baseUrl || 'http://localhost:8084/WebSproject/login.htm';
let vars = {};
jest.setTimeout(300000);
describe("Admin Basics", () => {
  it("Admin Switch views (admin and instructor)", async () => {
    await tests["Admin Switch views (admin and instructor)"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin switch view (from admin to instructor)", async () => {
    await tests["Admin switch view (from admin to instructor)"](driver, vars);
    expect(true).toBeTruthy();
  });
});
beforeEach(() => {
  vars = {};
});
afterEach(async () => (cleanup()));