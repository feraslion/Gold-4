# Gold-4 Accounting Suite

This is a professional accounting application designed to manage financial operations with support for Syrian Pounds (SYP) and US Dollars (USD). The project is structured as a monorepo to facilitate scalability, collaborative development, and integration with modern GitHub Actions for continuous integration and continuous delivery (CI/CD).

## Features

- **Multi-Currency Support**: Handle transactions in Syrian Pounds (SYP) and US Dollars (USD).
- **Monorepo Structure**: Organized for efficient development and maintenance of multiple applications (mobile, desktop, web) and shared packages.
- **GitHub Actions**: Automated workflows for analysis, testing, and release builds (APK, AAB, Windows EXE).
- **Quality Assurance**: Integration of `Very Good Analysis`, `dart_code_metrics`, `flutter_lints`, and comprehensive testing (Unit, Widget, Integration, Golden Tests).
- **Backend Services**: Robust API with authentication, WebSocket for real-time notifications, invoicing, inventory management, accounting, reporting, cloud sync, backups, and role-based permissions.
- **Database**: PostgreSQL for primary data storage, Redis for caching, MinIO for object storage, and Prisma ORM for database interactions.
- **Docker**: Containerized development and deployment environment using Docker Compose.
- **Project Tools**: Utilizes Melos for monorepo management, FVM for Flutter version management, Mason for code generation, Husky for Git hooks, Commitlint for commit message standards, and Prettier for code formatting.
- **Comprehensive Documentation**: API documentation, architecture diagrams, ERD, deployment guides, user manuals, and developer guides.

## Getting Started

### Prerequisites

- Flutter SDK
- Docker
- Git
- Melos (install globally: `pub global activate melos`)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/feraslion/Gold-4.git
   cd Gold-4
   ```

2. Bootstrap the monorepo:
   ```bash
   melos bootstrap
   ```

3. Run the mobile application (example):
   ```bash
   cd mobile
   flutter run
   ```

## Project Structure

```
accounting-suite/
├── .github/
│   ├── workflows/             # GitHub Actions workflows
│   ├── ISSUE_TEMPLATE/        # Issue templates
│   ├── PULL_REQUEST_TEMPLATE.md # Pull request template
│   ├── CODEOWNERS             # Code owners configuration
│   └── dependabot.yml         # Dependabot configuration
├── backend/                   # Backend services and API
├── mobile/                    # Flutter mobile application
├── desktop/                   # Flutter desktop application
├── web/                       # Flutter web application
├── packages/                  # Shared Flutter packages (core, shared, ui, network, etc.)
├── docs/                      # Project documentation
├── scripts/                   # Utility scripts
├── docker/                    # Docker configurations
├── assets/                    # Shared assets (images, fonts)
├── firebase/                  # Firebase configurations
├── database/                  # Database migrations and seeders
├── tools/                     # Development tools configurations
├── .vscode/                   # VS Code settings
├── .env.example               # Environment variables example
├── docker-compose.yml         # Docker Compose file
├── melos.yaml                 # Melos monorepo configuration
├── LICENSE                    # Project license
├── README.md                  # Project README
├── CHANGELOG.md               # Changelog
└── CODE_OF_CONDUCT.md         # Code of Conduct
```

## Contributing

We welcome contributions! Please see `CONTRIBUTING.md` for guidelines.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any inquiries, please open an issue on GitHub.
