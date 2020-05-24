## Darstellung der CI/CD Architektur der Infrakstruktur.
![](OutlineArchitectureOfTheInfrastructure.png)

## Auswahl und Begründung
Wir verwenden...

- **GitHub** - Kostenfrei, weitverbreitet und Erfahrungswerte vorhanden sind. Technisch sogrt Github für die Versionierung des Codes.
- **Jenkins** - Da es Kostenfrei und weitverbreitet ist, sowie einen guten Community-Support und unbegrenzte Erweiterungsmöglichkeiten bietet. Jenkins biete die Möglichkeit einen CI/CD Process für die Applikation zu erstellen.
- **Gulp** - Zum Scripten des Building-Processes.
- **Mocha.js** - Bietet eine sehr einfache Implementierung und ist das gängie Test-Framework für Node.js ist. 
- **Docker** - Unterstützt von den prominentesten CI-Lösungen, beschleunigt den Provisioningprozess.
- **Buildah & podman** - Als eventuelle Alternative zu Docker.
- **Cabot** - Self-Hosted, einfach zu deployen und alter service.

## Erklärung des Autmomationsprocesses

1. Die React App mit dem Jenkinsfile wird auf einen gesonderten "deploy" branch gepusht
2. Jenkins horcht auf diesen Branch pulled diesen und liest das Jenkinsfile aus sobald ein update verfügbar ist
3. Nach dem auslesen des Jenkinfiles startet Jenkins einen build
4. Jenkins startet GULP, um die dependencies zu fetchen
5. Jenkins startet Mocha.js und führt die Tests aus
6. Sollte der Build failen wird der Entwickler informiert
7. Ist der Build Succeded wird das Dockerfile im Projekt ausgelesen und ein Docker Container und Image erstellt
8. Jenkins deployed die App auf Digital Ocean
9. Cabot überprüft den status der Applikation auf Digital Ocean
