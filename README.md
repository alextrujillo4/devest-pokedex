## Pokédex: A Flutter Challenge for Aspiring Pokémon Masters

**Join forces with Devest** to bring the Pokédex to life, enabling trainers to access and manage their Pokémon collection seamlessly across Android, iOS, desktop, and web.

[ -> POKEDEX VIDEO DEMO HERE :)](pokedex.mov)

**My Mission:**

* **Develop a comprehensive Pokédex app** that fulfills the requirements outlined below.
* **Demonstrate your expertise** in Flutter, UI/UX design, and clean architecture.
* **Impress the Devest team** with your problem-solving skills and passion for Pokémon.

**Requirements:**

**Target Platforms:**
* Android
* iOS
* Desktop
* Web

**Core Features:**

1.  **Pokédex:**
   *   Display a list of all 151 Kanto region Pokémon.
   *   Implement a search bar to filter Pokémon by name.
   *   Allow users to navigate to a detailed view for each Pokémon.

2.  **Captured Pokémon:**
   *   Display a list of captured Pokémon, sorted by ID.
   *   Enable filtering by Pokémon type.
   *   Provide alphabetical sorting.
   *   Allow users to navigate to a detailed view for each captured Pokémon.

3.  **Pokémon Detail View:**
   *   Display essential Pokémon information:
      *   ID
      *   Name
      *   Image
      *   Height and weight (in API units)
      *   Types
   *   Implement a toggle button to mark/unmark the Pokémon as captured.
   *   Store captured Pokémon data locally.
   *   Maintain navigation history. 
   * 
4. EXTRA MADE (Detail): Make Pokedex Talk yo you :D (take a look at hear btn)

**UI Customization:**

*   **Default Theme:**
   *   Adopt the classic Pokédex "Red" or "Boston University Red" color scheme.
*   **Dynamic Theme:**
   *   Adapt the color palette based on the majority captured Pokémon type.
   *   Utilize the provided color reference for each type.

**Additional Considerations:**

*   Embrace best practices in Flutter development and clean architecture.
*   Leverage code quality control libraries.
*   Explore opportunities to enhance user experience (UX) and graphical user interface (GUI).

**Steps:**

1.  **Clone the Repository:**
    ```bash
    git clone <repository_url>
    ```

2.  **Set up the Development Environment:**
   * Follow the instructions provided in the repository to set up your development environment with Flutter version manager (fvm).

3.  **Install Dependencies:**
    ```bash
    make get
    ```

4.  **Build the Project:**
    ```bash
    make build
    ```
   * Note: Open an emulator if necessary.

5.  **Run the App:**
    ```bash
    fvm flutter run
    ```

**Additional Makefile Commands:**

The project utilizes a Makefile for various tasks. Refer to the provided Makefile within the repository for details on the following commands:

* Linting (`make lint`)
* Running Tests (`make tests`)
* Running Integration Tests (`make integration_tests`)
* Cleaning the Project (`make clean`)
* Creating an Android App  (`make create-android-app`)
* Creating an IOS App (`make create-android-app`)
* For more commands take a look at Makefile :) 

**Project Structure Overview:**

The project follows a modular approach, organizing code into separate packages and directories for better maintainability and scalability. Here's a summary of the key structures:

* **Features Packages (Presentation):** (Located at `lib/`)
   * Contains features related to specific functionalities like displaying Pokémon or managing captured Pokémon. (e.g., `most_popular`, `now_playing`, etc.)

* **Common Packages:** (Previously named Core Packages)
   * Located at `packages/commons/`
   * Houses utility functions for tasks like making HTTP requests or handling errors. (e.g., `network`, `failure`, etc.)

* **Domain/Data Packages:** (Located at `packages/core/`)
   * Represents the core data model and logic of the application.
   * Contains sub-packages for:
      * **Entity:** Domain entities representing data concepts 
      * **Params:** Parameter classes for passing data to use cases 
      * **Repository:** Interfaces for repositories defining data access methods 
      * **Usecase:** Use cases implementing the business logic of the application 

### Personal Info

I'm Alex Trujillo, a passionate software developer with a keen interest in mobile app development
using Flutter. You can find my work on:

* **Website:** [https://alextrujillo4.com/](https://alextrujillo4.com/)

I'm eager to showcase my skills :) Thank you to everyone at Devest :)
