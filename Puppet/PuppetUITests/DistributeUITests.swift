import XCTest

class DistributeUITests: XCTestCase {
  private var app : XCUIApplication?

  override func setUp() {
    super.setUp()

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app = XCUIApplication()
    app?.launch()
    guard let `app` = app else {
      return
    }

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

    // Enable SDK (we need it in case SDK was disabled by the test, which then failed and didn't enabled SDK back).
    let appCenterButton : XCUIElement = app.tables["App Center"].switches["Set Enabled"]
    if (!appCenterButton.boolValue) {
      appCenterButton.tap()
    }
  }

  func testDistribute() {
    guard let `app` = app else {
      XCTFail()
      return
    }

    // Go to distribute page and find "Set Enabled" button.
    app.tables["App Center"].staticTexts["Distribute"].tap()
    let distributeButton : XCUIElement = app.tables["Distribute"].switches["Set Enabled"]

    // Service should be enabled by default.
    XCTAssertTrue(distributeButton.boolValue)

    // Disable service.
    distributeButton.tap()

    // Button is disabled.
    XCTAssertFalse(distributeButton.boolValue)

    // Go back to start page.
    app.buttons["App Center"].tap()
    let appCenterButton : XCUIElement = app.tables["App Center"].switches["Set Enabled"]

    // SDK should be enabled.
    XCTAssertTrue(appCenterButton.boolValue)

    // Disable SDK.
    appCenterButton.tap()

    // Go to distribute page.
    app.tables["App Center"].staticTexts["Distribute"].tap()

    // Button should be disabled.
    XCTAssertFalse(distributeButton.boolValue)

    // Go back and enable SDK.
    app.buttons["App Center"].tap()
    appCenterButton.tap()

    // Go to distribute page.
    app.tables["App Center"].staticTexts["Distribute"].tap()
    
    // Service should be enabled.
    XCTAssertTrue(distributeButton.boolValue)
  }
}
