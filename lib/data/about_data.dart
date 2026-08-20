class AboutData {
  final String companyInfo;
  final Map<String, String> libraryLicenses;
  final String designLeadersLink;

  AboutData({
    required this.companyInfo,
    required this.libraryLicenses,
    required this.designLeadersLink,
  });

  static AboutData load() {
    // Placeholder for actual data loading
    return AboutData(
      companyInfo:
          "DesignLeaders.fi is a platform dedicated to open-source software and design leadership.",
      libraryLicenses: {
        "flutter": "MIT",
        "provider": "BSD-2-Clause",
        "google_fonts": "Apache-2.0",
      },
      designLeadersLink: "https://designleaders.fi",
    );
  }
}
