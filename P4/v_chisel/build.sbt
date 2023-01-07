name := "single_cycle_CPU_chisel"

version := "0.1"

scalaVersion := "2.13.7"

addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.0" cross CrossVersion.full)

libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.5.0"