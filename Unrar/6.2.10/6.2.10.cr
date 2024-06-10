class Target < ISM::Software
    
    def build
        super

        makeSource(["-f","makefile"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/bin")
        moveFile("#{mainWorkDirectoryPath}unrar","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/bin/unrar")
    end

end
