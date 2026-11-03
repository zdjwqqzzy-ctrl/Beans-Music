import XCTest

final class PlayerLayoutUITests: XCTestCase {
    func testTabletPlayerInBothOrientations() {
        let app = XCUIApplication()
        app.launchArguments = ["-ipad-player-preview"]
        app.launch()
        for orientation in [UIDeviceOrientation.landscapeLeft, .portrait] {
            XCUIDevice.shared.orientation = orientation
            let title = app.staticTexts["Evening Light"]
            let line = app.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Follow the light")).firstMatch
            XCTAssertTrue(title.waitForExistence(timeout: 15))
            XCTAssertTrue(line.waitForExistence(timeout: 10))
            // Both panes must remain on screen with lyrics to the right of metadata.
            XCTAssertLessThan(title.frame.midX, line.frame.midX)
            XCTAssertTrue(app.buttons["下一首"].isHittable)
            XCTAssertTrue(app.buttons["播放队列"].isHittable)
            let screenshot = XCTAttachment(screenshot: app.screenshot())
            screenshot.name = orientation == .portrait ? "iPad-portrait" : "iPad-landscape"
            screenshot.lifetime = .keepAlways
            add(screenshot)
        }
    }
}
