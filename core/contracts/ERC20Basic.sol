pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract ERC20Basic is ERC20, ERC20Detailed{
    constructor (
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint _initTotalSupply,
        address _owner
    )
        public
        ERC20Detailed(_name, _symbol, _decimals)
    {
        _mint(_owner, _initTotalSupply);
    }

    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    /**
     * @dev See {ERC20-_burnFrom}.
     */
    function burnFrom(address account, uint256 amount) public {
        _burnFrom(account, amount);
    }
}