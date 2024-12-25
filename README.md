# Land Registration System Using Blockchain


## Table of Contents

- [About](#About)
   - [Drawbacks of traditional system](#how-it-works)
   - [How it works](#drawbacks-of-the-traditional-system)
- [Tech Stack & Tools](#tech-stack--tools)
- [Key Features](#key-features)
- [Installation](#installation)
- [Usage](#usage)


# About

The Land Registration System Using Blockchain is a decentralized application (DApp) built on the Ethereum blockchain. 
It aims to revolutionize the traditional land registration process by leveraging blockchain technology. 

### Drawbacks of the traditional system
 
   *  Traditional system prone to fraud and manipulation.   
   *  Slow and cumbersome process for property tranfer.
   *  Manual paperwork leads to inefficiencies and delays.
   *  Lack of transparency in property ownership records.     
   *  Involvment of third parties in the process of purchase increases the costs.
   *  Difficulty in resolving disputes due to centralized control.
   *  Risk of data loss or corruption in centralized databases.

### How it works ?

This project contains mainly two steps:

1. **Decentralizing Land Registry data**:
   
   - In order to leverage blockchain technology to avoid drawbacks of the traditional system, we first need to decentrailze the property ownership data that is held by their respective government.
   
    - To decentralize the data, we have provided an option in the portal to the user for uploading their property details & documents as a proof to identify the ownership of the user.

    - Once the user has uploaded their documents, they should be verified by the respective government officer.
   
   - After the verification process is completed, if he/she is the legal owner of the property then officer will grants the ownership to the user or else they will reject it.

   - Once, after the approval of ownership, the property details & it's ownership details  will be stored in the blockchain.

   - Later, user can buy or sell a property from or to a person without involvment of any middlemen or any other problems of the traditional system that slows down the process.

2. **Ownership Transfer System**:
   - In order to sell the property to another person, user will **log into the land registry portal** using their credentials, there all the properties of the user are listed.

   - If the user wants to sell a particural property they can **make the property as available to sell for the price they wanted**.

   - Once, the user make their property available to sell, it is listed in a public page where **any interested buyer can send the purchase request to the owner with the price they want to offer**.

   - Owner can view all the purchase requests received to a particual property and **can accept the purchase request of a buyer**.

   - Later, buyer can **transfer the agreed payment amount** to the seller.

   - After the successfull payment transfer, the **ownership of the propery will be transferred** from the seller to the buyer.


## Tech Stack & Tools
```
* Flask==2.2.3 
* MongoDB
* Solidity
* Ethereum Blockchain
* Truffle
* Ganache
* Metamask
```

## Key Features:

- **Auction System**: Landowners can list their properties for sale and set their desired price through an auction mechanism.
- **Global Visibility**: Properties available for sale are visible to all users worldwide, allowing interested buyers to view and make offers.
- **Buyer Interaction**: Prospective buyers can submit buy requests with their offer prices, initiating the negotiation process.
- **Seller Decision-Making**: Landowners have the flexibility to review buy requests and select preferred buyers and offered prices.
- **Secure Transaction**: Upon acceptance of the transfer/buying proposal, buyers send Ether coins as payment, and ownership is seamlessly transferred.



**Screen shorts:** <br>
 <img src="readme_assests/1.User connecting their wallet.png" width="600" height="300"> 
 <img src="readme_assests/2.User Registration.png" width="600" height="300"> 
 <img src="readme_assests/3.Adding their land.png" width="600" height="300"> 
 <img src="readme_assests/4.Transaction to add land details.png" width="600" height="300"> 
 <img src="readme_assests/5.Revenue portal.png" width="600" height="300"> 
 <img src="readme_assests/6.Revenue officer accepting the land.png" width="600" height="300"> 
 <img src="readme_assests/7.Making the land available to sell.png" width="600" height="300"> 
 <img src="readme_assests/8.Buyer requesting purchase request.png" width="600" height="300"> 
 <img src="readme_assests/9.Seller accepting buyer request.png" width="600" height="300"> 
 <img src="readme_assests/10.Buyer making paymet.png" width="600" height="300"> 
 <img src="readme_assests/11.Ownership transferred to buyer.png" width="600" height="300"> 
<img src="readme_assests/User_contract.png" width = "200" height = "150">
<img src="readme_assests/Land_contract.png" width = "200" height = "150">
<img src="readme_assests/Property_contract.png" width = "200" height = "150">
<img src="readme_assests/Transfer_contract.png" width = "200" height = "150">
