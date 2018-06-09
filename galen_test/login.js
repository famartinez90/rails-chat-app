var username = arg.username;

driver.findElement(By.cssSelector("#login-box #user")).sendKeys(username);
driver.findElement(By.cssSelector("#login-box #submit")).click();

function pageIsLoaded() {
    return driver.findElement(By.id("navbar")) != null;
}

function waitFor(func) {
    var timeout = 10;

    while (timeout > 0 && !func()) {
        timeout = timeout - 1;
        Thread.sleep(1000);
    }

    if (!func()) {
        throw new Error("Wait timeout");
    }
}

waitFor(pageIsLoaded);
