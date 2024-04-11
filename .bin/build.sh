TAG_VERSION=$(head -n 1 ./VERSION)

increment_version() {
    local ver="$1"  # Input version (e.g., "1.0.0")
    local component="$2"

    # Split the version into major, minor, and patch components
    IFS='.' read -ra parts <<< "$ver"
    major="${parts[0]}"
    minor="${parts[1]}"
    patch="${parts[2]}"

    # Increment the specified component
    case "$component" in
        major)
            ((major++))
            minor=0
            patch=0
            ;;
        minor)
            ((minor++))
            patch=0
            ;;
        patch)
            ((patch++))
            ;;
        *)
            echo "Invalid component. Usage: $0 [major|minor|patch]"
            exit 1
            ;;
    esac

    # Construct the new version
    new_version="$major.$minor.$patch"
    echo "$new_version"
}

incremented_version=$(increment_version "$TAG_VERSION" "$1")

echo "$incremented_version" > ./VERSION

git add ./VERSION
git commit -m "version: update version to $incremented_version"

tag_version="v$incremented_version"
git tag -a "$tag_version" "Build $incremented_version for release"