const Property = artifacts.require("Property");

contract("Property", (accounts) => {
  let instance;

  before(async () => {
    instance = await Property.deployed();
  });

  it("should add a new property successfully", async () => {
    const locationId = 1;
    const revenueDepartmentId = 101;
    const surveyNumber = 5001;
    const owner = accounts[0];
    const area = 1000;

    const result = await instance.addLand(locationId, revenueDepartmentId, surveyNumber, owner, area, { from: accounts[0] });

    const propertyId = result.logs[0].args.propertyId.toNumber();
    assert.equal(propertyId, 1, "Property ID should be 1");
    assert.equal(result.logs[0].event, "LandAdded", "LandAdded event not emitted");
  });

  it("should retrieve property details correctly", async () => {
    const propertyId = 1;
    const land = await instance.getLandDetailsAsStruct(propertyId);

    assert.equal(land.locationId, 1, "Location ID does not match");
    assert.equal(land.area, 1000, "Area does not match");
  });

  it("should update property details", async () => {
    const propertyId = 1;
    const newArea = 2000;

    const result = await instance.updateLand(propertyId, 2, 102, 6001, accounts[0], newArea, accounts[1], "2024-01-01", "", 0, { from: accounts[0] });

    const land = await instance.getLandDetailsAsStruct(propertyId);
    assert.equal(result.logs[0].event, "LandUpdated", "LandUpdated event not emitted");
  });

  it("should change property state to Verified", async () => {
    const propertyId = 1;

    const result = await instance.changeStateToVerified(propertyId, accounts[1], { from: accounts[1] });

    const land = await instance.getLandDetailsAsStruct(propertyId);
    assert.equal(land.state, 2, "Property state not updated to Verified");
    assert.equal(result.logs[0].event, "LandStateChanged", "LandStateChanged event not emitted");
  });

  it("should remove property successfully", async () => {
    const propertyId = 1;

    await instance.removeLand(propertyId, { from: accounts[0] });

    try {
      await instance.getLandDetailsAsStruct(propertyId);
      assert.fail("Expected revert not received");
    } catch (error) {
      assert.include(error.message, "revert", "Land does not exist error not thrown");
    }
  });
});
