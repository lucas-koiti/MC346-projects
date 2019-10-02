-- Alunos:
-- Esdras Rodrigues do Carmo - RA: 170656
-- Lucas Koiti Geminiani Tamanaha - RA: 182579

import Data.List
import qualified Data.Map.Strict as M

data Point = Point [Float] String deriving (Show)

input = "a 0.0 0.0\nc 1000 2111\nb 2000 3000\n\na abababa\nc cbcbcbc"


dist (Point l1 _) (Point l2 _) = sqrt $ foldl (+) 0 $ zipWith (\a b -> (a - b)*(a - b)) l1 l2


isLabeled (Point _ label) = label /= ""


getLabel (Point _ label) = label


parseInput s = parser $ map words $ lines s
    where
    buildPoint l = Point (map (\s -> read s :: Float) (tail l)) ""
    updatePoint (Point _ label) (Point list _) = Point list label
    parser' [] acc _ = acc
    parser' (x:xs) acc isLabel = if isLabel 
        then parser' xs (M.insertWith updatePoint (head x) (Point [] (x!!1)) acc) isLabel
        else if x == []
            then parser' xs acc True
            else parser' xs (M.insert (head x) (buildPoint x) acc) isLabel
    parser l = parser' l M.empty False


detLabel (k, (Point p label)) list = (k, Point p (snd $ minimum distances))
    where
    distances = [((dist (Point p label) point), getLabel point) | (name, point) <- list, isLabeled point]


propagateLabels [] = []
propagateLabels l = propagateLabels' l []
    where 
    propagateLabels' [] _ = []
    propagateLabels' (p:px) acc = 
        if isLabeled $ snd p
            then
                (p : propagateLabels' px (p:acc))
            else
                (pLabeled : propagateLabels' px (pLabeled:acc))
        where
        pLabeled = detLabel p (acc ++ px)


formatOutput l = unlines $ map toStr $ M.toList $ formatOutput' l
    where
    formatOutput' [] = M.empty
    formatOutput' (p:px) = M.insertWith (++) (getLabel $ snd p) ([fst p]) (formatOutput' px)
    toStr (label, names) = label ++ " " ++ (unwords $ sort names)


main = do
    contents <- getContents
    putStrLn . formatOutput $ propagateLabels $ M.toList $ parseInput contents
