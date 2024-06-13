class Target < ISM::Software
    
    def build
        super

        makeSource( arguments:  "-f makefile",
                    path:       buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin")

        moveFile(   "#{mainWorkDirectoryPath}unrar",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/unrar")
    end

end
