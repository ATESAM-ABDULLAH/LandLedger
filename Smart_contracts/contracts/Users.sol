// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Users {
  
    // Struct to store user information.
    struct User {
        address userID;            // Unique address of the user.
        string firstName;          // User's first name.
        string lastName;           // User's last name.
        string dateOfBirth;        // User's date of birth.
        string CNIC;               // User's CNIC (National Identity Card) number.
        uint256 accountCreatedDateTime; // Timestamp when the user account was created.
    }

    // Mapping to track whether a user is already registered by their address.
    mapping(address => bool) private registeredUsers;

    // Mapping to store user details using their address as the key.
    mapping(address => User) public users;

    // Mapping to track whether a CNIC number has already been registered.
    mapping(string => bool) private CNICs;

    // Event to log the registration of a user.
    event UserRegistered(address indexed userID, uint256 indexed accountCreatedDateTime);

    // Function to register a new user.
    function registerUser(
        string memory _firstName,  // User's first name.
        string memory _lastName,   // User's last name.
        string memory _dateOfBirth, // User's date of birth.
        string memory _CNIC        // User's CNIC number.
    ) public {
        // Ensure that the user is not already registered.
        require(registeredUsers[msg.sender] == false, "User already registered");

        // Ensure that the CNIC number is not already registered.
        require(CNICs[_CNIC] == false, "CNIC already registered");

        // Create a new user instance and populate it with provided details.
        User memory newUser = User({
            userID: msg.sender,
            firstName: _firstName,
            lastName: _lastName,
            dateOfBirth: _dateOfBirth,
            CNIC: _CNIC,
            accountCreatedDateTime: block.timestamp // Use the current block timestamp for account creation time.
        });

        // Store the new user's information in the users mapping.
        users[msg.sender] = newUser;

        // Mark this user as registered.
        registeredUsers[msg.sender] = true;

        // Mark the CNIC number as used.
        CNICs[_CNIC] = true;

        // Emit the UserRegistered event to log the user registration.
        emit UserRegistered(msg.sender, block.timestamp);
    }

    // Function to fetch details of a registered user.
    function getUserDetails(
            address _userId  // Address of the user whose details are to be fetched.
        ) public view returns (
            string memory firstName, 
            string memory lastName, 
            string memory dateOfBirth, 
            string memory CNIC, uint256 accountCreated
            ) {

        // Ensure the user exists in the system.
        require(users[_userId].userID != address(0), "User does not exist");

        // Retrieve user details from the users mapping.
        User storage user = users[_userId];

        // Return the user's details.
        return (user.firstName, user.lastName, user.dateOfBirth, user.CNIC, user.accountCreatedDateTime);
    }
}
