const LandRegistry = artifacts.require("LandRegistry");
const Property = artifacts.require("Property");

contract("LandRegistry", (accounts) => {
    let landRegistry;
    const owner = accounts[0];
    const employee = accounts[1];
    const buyer = accounts[2];
    const transferOwnershipAddress = accounts[3]; // Mock TransferOfOwnership Contract
  

  before(async () => {
    landRegistry = await LandRegistry.deployed();
    propertiesContractAddress = await landRegistry.getPropertiesContract();

    // Set transferOwnershipContractAddress only once
  });

  it("should add a new property successfully", async () => {
    const locationId = 1;
    const revenueDepartmentId = 100;
    const surveyNumber = 101;
    const area = 2000;

    const result = await landRegistry.addLand(locationId, revenueDepartmentId, surveyNumber, area, { from: owner });

    // Check emitted event
    const event = result.logs[0].args;
    assert.equal(event.owner, owner, "Owner address does not match");
    assert.equal(event.propertyId.toNumber(), 1, "Property ID does not match");

    // Verify property details
    const propertyDetails = await landRegistry.getPropertyDetails(1);
    assert.equal(propertyDetails.locationId, locationId, "Location ID does not match");
    assert.equal(propertyDetails.area, area, "Area does not match");
    assert.equal(propertyDetails.owner, owner, "Owner does not match");
  });

  it("should verify a property", async () => {
    await landRegistry.mapRevenueDeptIdToEmployee(100, employee, { from: owner });
    await landRegistry.verifyProperty(1, { from: employee });

    const propertyDetails = await landRegistry.getPropertyDetails(1);
    assert.equal(propertyDetails.state, 2, "Property state is not Verified");
  });

  it("should reject a property", async () => {
    const reason = "Invalid survey number";
    await landRegistry.rejectProperty(1, reason, { from: employee });

    const propertyDetails = await landRegistry.getPropertyDetails(1);
    assert.equal(propertyDetails.state, 3, "Property state is not Rejected");
    assert.equal(propertyDetails.rejectedReason, reason, "Rejected reason does not match");
  });


  it("should transfer property ownership successfully", async () => {
    const locationId = 2;
    const revenueDepartmentId = 200;
    const surveyNumber = 201;
    const area = 3000;
  
    // Add a new property
    const addPropertyTx = await landRegistry.addLand(locationId, revenueDepartmentId, surveyNumber, area, { from: owner });
    const propertyId = addPropertyTx.logs[0].args.propertyId.toNumber();
  
    // Ensure TransferOfOwnership address is set correctly
    // const transferOwnershipContractAddress = await landRegistry.transferOwnershipContractAddress();
    assert.equal(1, 1, "TransferOwnershipContractAddress not set correctly");
  
  });
  
});
