# Contributing to Gold-4 Accounting Suite

We welcome contributions to the Gold-4 Accounting Suite! To ensure a smooth and collaborative development process, please follow these guidelines.

## How to Contribute

1.  **Fork the Repository**: Start by forking the `feraslion/Gold-4` repository to your GitHub account.
2.  **Clone Your Fork**: Clone your forked repository to your local machine.
    ```bash
    git clone https://github.com/YOUR_USERNAME/Gold-4.git
    cd Gold-4
    ```
3.  **Create a New Branch**: Create a new branch for your feature or bug fix. Use a descriptive name (e.g., `feature/add-multi-currency`, `bugfix/login-issue`).
    ```bash
    git checkout -b feature/your-feature-name
    ```
4.  **Set Up Environment**: Ensure you have Flutter SDK, Docker, Git, and Melos installed. Run `melos bootstrap` to set up the monorepo.
5.  **Make Changes**: Implement your changes, ensuring they adhere to the project's coding style and quality standards.
6.  **Test Your Changes**: Write and run tests to ensure your changes work as expected and do not introduce regressions.
7.  **Commit Your Changes**: Write clear and concise commit messages following the Conventional Commits specification. This project uses `commitlint` to enforce commit message standards.
    ```bash
    git commit -m "feat: add multi-currency support"
    ```
8.  **Push to Your Fork**: Push your changes to your forked repository.
    ```bash
    git push origin feature/your-feature-name
    ```
9.  **Create a Pull Request**: Open a pull request from your branch to the `main` branch of the original `feraslion/Gold-4` repository. Provide a detailed description of your changes.

## Code Style and Quality

-   We use `flutter_lints` and `very_good_analysis` for static analysis. Please ensure your code passes all lint checks.
-   Format your code using `Prettier`.
-   Write unit, widget, and integration tests for new features and bug fixes.

## Reporting Bugs

If you find a bug, please open an issue on GitHub. Provide a clear description, steps to reproduce, and expected behavior.

## Suggesting Enhancements

For feature requests or enhancements, please open an issue to discuss your ideas.

## Code of Conduct

Please review our [Code of Conduct](CODE_OF_CONDUCT.md) to understand the expected behavior within our community.
