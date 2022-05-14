//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Lucky {
    string public textRaw;
    address private owner;
    uint256 public angka;

    constructor() {
        owner = msg.sender;
    }

    function setText(string calldata _text) external {
        textRaw = _text;
    }

    function increment() external {
        require(msg.sender == owner, "NOT_OWNER");
        angka++;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
