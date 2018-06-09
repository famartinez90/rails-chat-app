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

function homeIsLoaded() {
    return driver.findElement(By.id("navbar")) != null;
}

function groupIsCreated() {
    return driver.findElement(By.cssSelector(".btn-success")) != null;
}

function chatIsLoaded() {
    return driver.findElement(By.id("messages")) != null;
}

function bubbleShows() {
    Thread.sleep(1500);
    return driver.findElement(By.cssSelector(".bubble")) != null;
}

var username = arg.username;

driver.findElement(By.cssSelector("#login-box #user")).sendKeys(username);
driver.findElement(By.cssSelector("#login-box #submit")).click();

waitFor(homeIsLoaded);

var groupname = arg.groupname;

driver.findElement(By.id("gname")).sendKeys(groupname);
driver.findElement(By.id("submit")).click();

waitFor(groupIsCreated);

var elements = driver.findElements(By.cssSelector(".btn-success"));
elements.get(elements.size() - 1).click();

waitFor(chatIsLoaded);

driver.findElement(By.id("speak-input")).sendKeys("test message");
driver.findElement(By.id("speak-input")).sendKeys('\uE007');

waitFor(bubbleShows);