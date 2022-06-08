const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    video: false,
    videosFolder: this.video ? "cypress/videos" : '',
    screenshotOnRunFailure: false,
    excludeSpecPattern: '**/e2e/2-advanced-examples/*.cy.js',
    setupNodeEvents(on, config) {
      // implement node event listeners here
      on('before:browser:launch', (browser = {}, launchOptions) => {
        if (browser.family === 'chromium') {
          launchOptions.args.push('--disable-dev-shm-usage')
          launchOptions.args.push('--disable-gpu')
          launchOptions.args.push('--disable-extensions')
          launchOptions.args.push('--ignore-certificate-errors')
          launchOptions.args.push('--disable-software-rasterizer')
        }
        return launchOptions
      })
    }
  }
})
