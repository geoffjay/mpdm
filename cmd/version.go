package cmd

import (
	"fmt"

	"github.com/geoffjay/mpdm/pkg"

	"github.com/spf13/cobra"
)

var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Print the version number of mpdm",
	Long:  `MPDM version information.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(pkg.VERSION)
	},
}
