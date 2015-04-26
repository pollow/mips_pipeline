name := "LearnChisel"

version := "1.0"

scalaVersion := "2.11.6"

resolvers ++= Seq( "scct-github-repository" at
  "http://mtkopone.github.com/scct/maven-repo"
)

libraryDependencies +=
  "edu.berkeley.cs" %% "chisel" % "latest.release"
