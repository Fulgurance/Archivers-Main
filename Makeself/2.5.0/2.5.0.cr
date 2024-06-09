class Target < ISM::Software
    
    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin")

        moveFile("#{mainWorkDirectoryPath(false)}/maketest.sh","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/bin/maketest")
    end

    def install
        super

        runChmodCommand(["+x","/usr/bin/maketest"])
    end

end
