using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEngine;

public class ApplicationBuilder
{
    public static void Build()
    {
        const string outputDirKey = "-output-dir";

        var args = Environment.GetCommandLineArgs();
        var locationPathName = GetArgumentValue(args, outputDirKey);

        var options = new BuildPlayerOptions();
        options.scenes = EditorBuildSettingsScene.GetActiveSceneList(EditorBuildSettings.scenes);
        options.locationPathName = GetArgumentValue(args, "-output-dir");
        options.target = BuildTarget.iOS;
        options.options = BuildOptions.None;

        var buildReport = BuildPipeline.BuildPlayer(options);

        if (buildReport.summary.result == BuildResult.Succeeded)
        {
            Debug.Log("[Success]");
            EditorApplication.Exit(0);
        }
        else
        {
            Debug.Log("[Failure]" + buildReport);
            EditorApplication.Exit(1);
        }
    }

    private static string GetArgumentValue(IReadOnlyList<string> args, string key)
    {
        var index = args.ToList().FindIndex(arg => arg == key);
        var paramIndex = index + 1;

        if (index < 0 || args.Count() <= paramIndex)
        {
            return null;
        }

        return args[paramIndex];
    }
}

