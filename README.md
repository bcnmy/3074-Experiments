# Smart Contract Template Base 🚀

This repository serves as a comprehensive foundation for smart contract projects, streamlining the development process with a focus on best practices, security, and efficiency.

[![Hardhat](https://img.shields.io/badge/Built%20with-Hardhat-FFDB1C.svg)](https://hardhat.org/) [![Foundry](https://img.shields.io/badge/Built%20with-Foundry-FFBD10.svg)](https://getfoundry.sh/)

![Codecov Hardhat Coverage](https://img.shields.io/codecov/c/gh/bcnmy/sc-template?token=2BYDIFQ56W&flag=hardhat&label=Hardhat-coverage) ![Codecov Foundry Coverage](https://img.shields.io/codecov/c/gh/bcnmy/sc-template?token=2BYDIFQ56W&flag=foundry&label=Foundry-coverage) ![Codecov Project Coverage](https://img.shields.io/codecov/c/gh/bcnmy/sc-template?token=2BYDIFQ56W&label=Project-coverage)

## Features

- **Smart Contract Template Base**: A robust foundation for future smart contract projects.
- **Hardhat & Foundry Support**: Equipped with both Hardhat and Foundry tools, along with an adapted folder structure for seamless development.
- **Best Practices**: Adheres to industry best practices in smart contract programming to ensure code quality and security.
- **Continuous Integration & Deployment**: Utilizes GitHub Actions for automated testing and deployment, ensuring code reliability.
- **Strict Linting**: Implements Solhint based on the Solidity style guide, enhancing code quality and consistency.
- **Comprehensive Testing**: Includes a wide range of tests (unit, fuzz, fork) for both Foundry and Hardhat environments.
- **Environment Configuration**: Comes with `.env.example` for easy setup of API keys and environmental variables.
- **Code Formatting**: Uses Prettier to maintain a consistent code style across the project.
- **Configurations for Foundry & Hardhat**: Provides essential settings and scripts for building, testing, and deployment, tailored for both development environments.

## Getting Started

To kickstart your smart contract development with this template, follow these steps:

### Prerequisites

- Node.js (v14.x or later)
- Yarn (or npm)
- Foundry (Refer to [Foundry installation instructions](https://getfoundry.sh/docs/installation))

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/bcnmy/sc-template.git
cd sc-template
```

2. **Install dependencies:**

```bash
yarn install
```

3. **Setup environment variables:**

Copy `.env.example` to `.env` and fill in your details.

### Usage

- **Compile contracts**: `yarn build`
- **Run tests**: `yarn test`
- **Deploy contracts**: Use the provided scripts for deployment on local or test networks.

## Contributing

Your contributions are welcome! Please refer to the contributing guidelines for how to propose improvements or submit pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/bcnmy/sc-template/blob/master/LICENSE) file for details.

## Contact

Biconomy - [@bcnmy](https://twitter.com/bcnmy)

## Acknowledgements

- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) for secure contract standards.
- Contributors and supporters who make open-source development possible.
