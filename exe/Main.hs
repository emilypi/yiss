module Main where


import Options.Applicative
import Yiss.Config


main :: IO ()
main = awwYiss =<< execParser yissOpts

awwYiss :: YissConfig -> IO ()
awwYiss _ = return ()

yissOpts :: ParserInfo YissConfig
yissOpts = info (pYissConfig <**> helper)
    ( fullDesc
    <> progDesc "Aww Yiss! irc bot servant server"
    )

-- | 'YissConfig' option parser. The following options are supported:
--
-- - `--hostname=HOSTNAME|-h`: supply a stringified hostname
--   address to connect to.
--
-- - `--port=PORT|-p`: supply a port service name to use in connection
--
-- - `--verbose=VERBOSITY|-v`: specify debut level. Levels include:
--   - 0: quiet
--   - 1: info
--   - 2: warn
--   - 3: debug
--
-- - `--quote-database=DB|-q`: quote database location
--
pYissConfig :: Parser YissConfig
pYissConfig = YissConfig
    <$> strOption
      ( long "hostname"
      <> metavar "HOSTNAME"
      <> short 'h'
      <> help "Target hostname address"
      )
    <*> strOption
      ( long "port"
      <> metavar "PORT"
      <> short 'h'
      <> showDefault
      <> value "6667"
      <> help "Target port address. Defaults to 6667."
      )
    <*> option auto
      ( long "verbose"
      <> short 'v'
      <> metavar "VERBOSITY"
      <> showDefault
      <> value 1
      <> help "Switch to verbose mode. Defaults to info."
      )
    <*> option auto
      ( long "quote-database"
      <> short 'q'
      <> showDefault
      <> value "."
      <> metavar "DB"
      <> help "quote database location"
      )
