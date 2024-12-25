const Users = artifacts.require("Users");

contract("Users", (accounts) => {
  let instance;

  before(async () => {
    instance = await Users.deployed();
  });

  it("should register a new user successfully", async () => {
    const firstName = "John";
    const lastName = "Doe";
    const dateOfBirth = "1990-01-01";
    const CNIC = "12345-6789012-3";

    const result = await instance.registerUser(
      firstName,
      lastName,
      dateOfBirth,
      CNIC,
      { from: accounts[0] }
    );

    const event = result.logs[0];
    assert.equal(event.event, "UserRegistered", "Event UserRegistered not emitted");
    assert.equal(event.args.userID, accounts[0], "UserID does not match");
  });

  it("should not allow duplicate CNIC registration", async () => {
    const firstName = "Jane";
    const lastName = "Doe";
    const dateOfBirth = "1992-02-02";
    const CNIC = "12345-6789012-3"; // Same CNIC as before

    try {
      await instance.registerUser(firstName, lastName, dateOfBirth, CNIC, {
        from: accounts[1],
      });
      assert.fail("Expected revert not received");
    } catch (error) {
      assert.include(
        error.message,
        "revert",
        "CNIC already registered error not thrown"
      );
    }
  });

  it("should fetch user details correctly", async () => {
    const userDetails = await instance.getUserDetails(accounts[0]);

    assert.equal(userDetails.firstName, "John", "First name does not match");
    assert.equal(userDetails.lastName, "Doe", "Last name does not match");
    assert.equal(userDetails.dateOfBirth, "1990-01-01", "DOB does not match");
    assert.equal(userDetails.CNIC, "12345-6789012-3", "CNIC does not match");
  });

  it("should not allow fetching details of non-existent user", async () => {
    try {
      await instance.getUserDetails(accounts[2]);
      assert.fail("Expected revert not received");
    } catch (error) {
      assert.include(
        error.message,
        "revert",
        "User does not exist error not thrown"
      );
    }
  });
});
