jest.setMock('selenium-webdriver', webdriver);
// This file was generated using Selenium IDE
const tests = require("./commons.js");
global.Key = require('selenium-webdriver').Key;
global.URL = require('url').URL;
global.BASE_URL = configuration.baseUrl || 'http://localhost:8084/WebSproject/login.htm';
let vars = {};
jest.setTimeout(300000);
describe("Admin Actions", () => {
  it("Admin login; Insert, update and delete category", async () => {
    await tests["Admin login; Insert, update and delete category"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin login; Insert, update and delete streams", async () => {
    await tests["Admin login; Insert, update and delete streams"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin login; Insert, update and delete courses", async () => {
    await tests["Admin login; Insert, update and delete courses"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin login; Insert, update and delete modules", async () => {
    await tests["Admin login; Insert, update and delete modules"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin login; Insert, update and delete user (admin & instructor)", async () => {
    await tests["Admin login; Insert, update and delete user (admin & instructor)"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin login; Switch view to instructor; Create class", async () => {
    await tests["Admin login; Switch view to instructor; Create class"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin login; Switch view to instructor; Search and email", async () => {
    await tests["Admin login; Switch view to instructor; Search and email"](driver, vars);
    expect(true).toBeTruthy();
  });
  it("Admin login; Switch view to instructor; Search employee and delete", async () => {
    await tests["Admin login; Switch view to instructor; Search employee and delete"](driver, vars);
    expect(true).toBeTruthy();
  });
});
beforeEach(() => {
  vars = {};
});
afterEach(async () => (cleanup()));