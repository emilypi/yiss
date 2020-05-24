{-# LANGUAGE BangPatterns #-}
module Yiss.Config
( YissConfig(..)
) where


import Numeric.Natural

-- | Yiss bot configuration record
--
data YissConfig =
  YissConfig
    { _hostname :: String
    , _port :: String
    , _verbosity :: !Natural
    , _quotedb :: String
    }
