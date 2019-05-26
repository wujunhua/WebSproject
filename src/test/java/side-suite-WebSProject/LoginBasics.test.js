jest.setMock('selenium-webdriver', webdriver);
// This file was generated using Selenium IDE
const tests = require("./commons.js");
global.Key = require('selenium-webdriver').Key;
global.URL = require('url').URL;
global.BASE_URL = configuration.baseUrl || 'http://localhost:8084/WebSproject/login.htm';
let vars = {};
jest.setTimeout(300000);
describe("Login Basics", () => {
  it("Instructor login success does not have admin tab", async () => {
    await tests["Instructor login success does not have admin tab"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin login success does have instructor tab", async () => {
    await tests["Admin login success does have instructor tab"](driver, vars);
    expect(true).toBeTruthy();
  });
});
beforeEach(() => {
  vars = {};
});
afterEach(async () => (cleanup()));