package cmd

import (
	"log"
	"os"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var (
	cfgFile string
	// Config     *context.Config
	Verbose bool

	rootCmd = &cobra.Command{
		Use:   "mpdm",
		Short: "Multi-product development manager",
		Long:  `A management utility for working with development environments.`,
	}
)

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		log.Fatal(err)
		os.Exit(1)
	}
}

func init() {
	// cobra.OnInitialize(initConfig)

	addCommands()

	// Setup command flags
	rootCmd.PersistentFlags().StringVarP(&cfgFile, "config", "c", "", "config file (default is $HOME/.config/mpdm/config.yml)")
	rootCmd.PersistentFlags().BoolVarP(&Verbose, "verbose", "v", false, "verbose output")

	_ = viper.BindPFlag("verbose", rootCmd.PersistentFlags().Lookup("verbose"))

	viper.SetDefault("verbose", false)
}

func addCommands() {
	// rootCmd.AddCommand(serverCmd)

	// Miscellaneous commands
	rootCmd.AddCommand(versionCmd)
}
