class Target < ISM::Software
    
    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin")

        moveFile(   "#{mainWorkDirectoryPath}/makeself.sh",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/makeself")
    end

end
