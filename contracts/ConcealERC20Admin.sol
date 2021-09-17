pragma solidity ^0.8.0;
import "./ConcealERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ConcealERC20Admin {
    struct Entry {
        uint256 index;
        address addr;
        address token;
    }

    address public owner = msg.sender;
    address public mixr;
    address public verifier;

    uint256[] internal denominations;
    mapping(address => Entry) internal Conceals;

    event ConcealDeployed(uint256 denomination, address addr);
    event ConcealRemoved(uint256 denomination, address addr);

    constructor(address mixr_, address verifier_) {
        mixr = mixr_;
        verifier = verifier_;
    }

    function transferOwner(address _owner) public restricted {
        owner = _owner;
    }

    modifier restricted() {
        require(
            msg.sender == owner,
            "This function is restricted to the contract's owner"
        );
        _;
    }

    function createConceal(uint256 denomination, address token, address commmAdd) public restricted {
        ConcealERC20 newConceal = new ConcealERC20(mixr, verifier, denomination, token, commmAdd);
        emit ConcealDeployed(denomination, address(newConceal));
    }

    function getDenominations() public view returns (uint256[] memory) {
        return denominations;
    } 
}
