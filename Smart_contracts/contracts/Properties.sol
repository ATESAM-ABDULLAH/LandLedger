// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Property {
    
    // Enum to represent various states of a property.
    enum StateOfProperty { 
        Created,        // Initial state when property details are added by the user.
        Scheduled,      // When a surveyor is scheduled for verification.
        Verified,       // When the property is verified by the surveyor.
        Rejected,       // When the property is rejected by the surveyor.
        OnSale,         // When the property is marked as available for sale.
        Bought          // When the property is sold and ownership is transferred.
    }
    
    // Struct to store property details.
    struct Land {
        uint256 propertyId;          // Unique identifier for the property.
        uint256 locationId;          // Identifier for the property location.
        uint256 revenueDepartmentId; // Identifier for the revenue department.
        uint256 surveyNumber;        // Survey number of the property.
        address owner;               // Address of the property's owner.
        uint256 area;                // Area of the property in square units.
        uint256 price;               // Price of the property.
        uint256 registeredTime;      // Timestamp of when the property was registered.
        address employeeId;          // Address of the employee involved in verification.
        string scheduledDate;        // Date when the property verification is scheduled.
        string rejectedReason;       // Reason for rejection, if applicable.
        StateOfProperty state;       // Current state of the property.
    }

    // Mapping to store properties by their unique property ID.
    mapping(uint256 => Land) public lands;

    // Counter to generate unique property IDs.
    uint256 private landCount;

    // Events to emit changes to Land
    event LandAdded(uint256 indexed propertyId, address indexed owner, uint256 area, uint256 timestamp);
    event LandUpdated(uint256 indexed propertyId, address indexed owner, uint256 area, uint256 timestamp);
    event LandStateChanged(uint256 indexed propertyId, StateOfProperty newState, address updatedBy, uint256 timestamp);

    
    // Function to add a new property.
    function addLand(
        uint256 _locationId,          // Location ID of the property.
        uint256 _revenueDepartmentId, // Revenue department ID of the property.
        uint256 _surveyNumber,        // Survey number of the property.
        address _owner,               // Address of the property's owner.
        uint256 _area                 // Area of the property.
    ) public returns (uint256) {
        landCount++; // Increment the property ID counter.

        // Create a new Land instance and add it to the mapping.
        lands[landCount] = Land({
            propertyId: landCount,
            locationId: _locationId,
            revenueDepartmentId: _revenueDepartmentId,
            surveyNumber: _surveyNumber,
            owner: _owner,
            area: _area,
            price: 0,
            registeredTime: block.timestamp,
            employeeId: address(0),
            scheduledDate: "",
            rejectedReason: "",
            state: StateOfProperty.Created
        });

        // Emit result for test
        emit LandAdded(landCount, _owner, _area, block.timestamp);

        // Return the newly created property ID.
        return landCount;
    }

    // Function to retrieve property details as a struct.
    function getLandDetailsAsStruct(uint256 _propertyId) public view returns (Land memory) {
        require(lands[_propertyId].propertyId != 0, "Land does not exist"); // Ensure the property exists.

        // Return the property details.
        return lands[_propertyId];
    }

    // Function to remove a property from the records.
    function removeLand(uint256 _propertyId) public {
        require(lands[_propertyId].propertyId != 0, "Land does not exist"); // Ensure the property exists.

        // Delete the property from the mapping.
        delete lands[_propertyId];
    }

    // Function to update property details.
    function updateLand(
        uint256 _propertyId,
        uint256 _locationId,
        uint256 _revenueDepartmentId,
        uint256 _surveyNumber,
        address _owner,
        uint256 _area,
        address _employeeId,
        string memory _scheduledDate,
        string memory _rejectedReason,
        StateOfProperty _state
    ) public{
        require(lands[_propertyId].propertyId != 0, "Land does not exist"); // Ensure the property exists.

        // Update the property details.
        lands[_propertyId].locationId = _locationId;
        lands[_propertyId].revenueDepartmentId = _revenueDepartmentId;
        lands[_propertyId].surveyNumber = _surveyNumber;
        lands[_propertyId].owner = _owner;
        lands[_propertyId].area = _area;
        lands[_propertyId].employeeId = _employeeId;
        lands[_propertyId].scheduledDate = _scheduledDate;
        lands[_propertyId].rejectedReason = _rejectedReason;
        lands[_propertyId].state = _state;

        // Emit event +  Results for test
        emit LandUpdated(_propertyId, _owner, _area, block.timestamp);
    }

    // Function to change the state of a property to Verified.
    function changeStateToVerified(uint256 _propertyId, address _employeeId) public {
        require(lands[_propertyId].propertyId != 0, "Land does not exist"); // Ensure the property exists.

        // Update the property state and the employee involved.
        lands[_propertyId].employeeId = _employeeId;
        lands[_propertyId].state = StateOfProperty.Verified;

        emit LandStateChanged(_propertyId, StateOfProperty.Verified, msg.sender, block.timestamp);
    }

    // Function to change the state of a property to Rejected.
    function changeStateToRejected(uint256 _propertyId, address _employeeId, string memory _reason) public {
        require(lands[_propertyId].propertyId != 0, "Land does not exist"); // Ensure the property exists.

        // Update the property state, rejection reason, and the employee involved.
        lands[_propertyId].employeeId = _employeeId;
        lands[_propertyId].state = StateOfProperty.Rejected;
        lands[_propertyId].rejectedReason = _reason;

        emit LandStateChanged(_propertyId, StateOfProperty.Verified, msg.sender, block.timestamp);
    }

    // Function to change the state of a property to OnSale.
    function changeStateToOnSale(uint256 _propertyId, address _owner) public {
        require(lands[_propertyId].propertyId != 0, "Land does not exist"); // Ensure the property exists.
        require(lands[_propertyId].owner == _owner, "Only owner can make available to sell"); // Ensure only the owner can update.

        // Update the property state.
        lands[_propertyId].state = StateOfProperty.OnSale;

        emit LandStateChanged(_propertyId, StateOfProperty.Verified, msg.sender, block.timestamp);

    }

    // Function to revert the state of a property back to Verified.
    function changeStateBackToVerified(uint256 _propertyId, address _owner) public {
        require(lands[_propertyId].propertyId != 0, "Land does not exist"); // Ensure the property exists.
        require(lands[_propertyId].owner == _owner, "Only owner is allowed"); // Ensure only the owner can update.

        // Update the property state.
        lands[_propertyId].state = StateOfProperty.Verified;

        emit LandStateChanged(_propertyId, StateOfProperty.Verified, msg.sender, block.timestamp);

    }

    // Function to update the owner of a property.
    function updateOwner(uint256 _propertyId, address newOwner) public {
        require(lands[_propertyId].propertyId != 0, "Land does not exist"); // Ensure the property exists.

        // Change ownership and update state to Bought.
        lands[_propertyId].owner = newOwner;
        lands[_propertyId].state = StateOfProperty.Bought;

        emit LandStateChanged(_propertyId, StateOfProperty.Verified, msg.sender, block.timestamp);

    }
}
